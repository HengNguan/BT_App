import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../generated/l10n.dart';

class BluetoothHomePage extends StatefulWidget {
  const BluetoothHomePage({Key? key}) : super(key: key);

  @override
  _BluetoothHomePageState createState() => _BluetoothHomePageState();
}

class _BluetoothHomePageState extends State<BluetoothHomePage> {
  List<ScanResult> scanResults = [];
  bool isScanning = false;
  BluetoothAdapterState bluetoothState = BluetoothAdapterState.unknown;
  String connectionStatus = ''; // 显示连接状态
  List<String> dataPackets = []; // 用于保存数据包
  List<Map<String, dynamic>> parsedDataPackets = []; // 用于保存解析后的数据

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  // 检查蓝牙状态，并监听蓝牙开关
  void _checkBluetoothState() async {
    if (await FlutterBluePlus.isSupported == false) {
      print(S.of(context).notSupportThisDevice);
      return;
    }

    // 监听蓝牙状态
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      setState(() {
        bluetoothState = state;
      });
      if (state == BluetoothAdapterState.on) {
        print(S.of(context).bluetoothIsOn);
      } else {
        print(S.of(context).bluetoothIsOff);
      }
    });

    // 安卓设备自动打开蓝牙
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  // 开始扫描蓝牙设备
  void _startScanning() async {
    if (bluetoothState != BluetoothAdapterState.on) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).turnOnBluetooth),
      ));
      return;
    }

    setState(() {
      isScanning = true;
      scanResults.clear();
    });

    var subscription = FlutterBluePlus.onScanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });

    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
    );

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
    FlutterBluePlus.cancelWhenScanComplete(subscription);

    setState(() {
      isScanning = false;
    });
  }

  // 连接蓝牙设备
  void _connectToDevice(BluetoothDevice device) async {
    setState(() {
      connectionStatus = S.of(context).connecting;
    });

    // 监听设备断开连接事件
    var subscription =
        device.connectionState.listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.connected) {
        setState(() {
          connectionStatus = S.of(context).successfulConnect;
        });
        // 一旦连接成功，开始监听通知
        _listenForDataPackets(device);
      }
      if (state == BluetoothConnectionState.disconnected) {
        print(
            "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
        setState(() {
          connectionStatus = S.of(context).disconnected;
        });
      }
    });

    // 连接设备
    await device.connect();

    // 取消订阅防止重复监听
    device.cancelWhenDisconnected(subscription, delayed: true, next: true);
  }

  // 持续监听数据包
  void _listenForDataPackets(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    for (var service in services) {
      for (var characteristic in service.characteristics) {
        // 如果特性支持通知
        if (characteristic.properties.notify) {
          characteristic.value.listen((value) {
            _onDataPacketReceived(value); // 处理接收到的数据包
          });
          await characteristic.setNotifyValue(true); // 启用通知
        }
      }
    }
  }

  // 处理接收到的数据包
  void _onDataPacketReceived(List<int> dataPacket) {
    // 将接收到的数据包转换为十六进制字符串
    String hexString = dataPacket
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join('');
    setState(() {
      dataPackets.add('${dataPackets.length + 1}: 0x$hexString');
    });

    // 如果数据包长度大于或等于 16 字节，进行解析
    if (dataPacket.length >= 16) {
      _parseDataPacket(dataPacket.sublist(0, 16)); // 仅解析前 16 字节
    }
  }

  // 解析数据包
  void _parseDataPacket(List<int> dataPacket) {
    Map<String, dynamic> parsedData = {
      'Length': dataPacket[0],
      'Product Type': dataPacket[1],
      'Serial Number': dataPacket
          .sublist(2, 6)
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join(),
      'Power Status': dataPacket[6] == 1 ? 'On' : 'Off',
      'Temperature': ((dataPacket[7] << 8) | dataPacket[8]) / 10.0,
      'Weight': ((dataPacket[9] << 8) | dataPacket[10]) / 1.0,
      'Battery': dataPacket[12],
      'Reserved': dataPacket
          .sublist(13, 15)
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join(),
      'Checksum': dataPacket[15],
    };

    setState(() {
      parsedDataPackets.add(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bluetoothScanner),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _startScanning,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: isScanning ? null : _startScanning,
              child: Text(isScanning ? 'Scanning...' : 'Scan for Devices'),
            ),
          ),
          Text(connectionStatus,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (context, index) {
                final result = scanResults[index];
                final device = result.device;
                final deviceName = result.advertisementData.localName.isNotEmpty
                    ? result.advertisementData.localName
                    : 'Unknown Device';

                return ListTile(
                  title: Text(deviceName),
                  subtitle: Text('ID: ${device.remoteId}'),
                  onTap: () => _connectToDevice(device),
                );
              },
            ),
          ),
          const Divider(),
          Text(S.of(context).dataPacketReceived),
          Expanded(
            child: ListView.builder(
              itemCount: dataPackets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataPackets[index]),
                );
              },
            ),
          ),
          const Divider(),
          Text(S.of(context).parsedData),
          Expanded(
            child: ListView.builder(
              itemCount: parsedDataPackets.length,
              itemBuilder: (context, index) {
                final packet = parsedDataPackets[index];
                return ListTile(
                  title: Text(
                      'Packet ${index + 1}: Length=${packet['Length']}, Product Type=${packet['Product Type']}, Serial Number=${packet['Serial Number']}, Power Status=${packet['Power Status']}, Temperature=${packet['Temperature']}°C, Weight=${packet['Weight']}g, Battery=${packet['Battery']}, Reserved=${packet['Reserved']}, Checksum=${packet['Checksum']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
