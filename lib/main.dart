import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'generated/l10n.dart';
import 'package:untitled2/screens/calendar_page.dart';

void main() {
  runApp(const BluetoothApp());
}

class BluetoothApp extends StatelessWidget {
  const BluetoothApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth App',
      //initialRoute: '/',
      //routes: {
      //  '/': (context) =>  HomeScreen(),
      //  '/default': (context) => defaultPage(),
      //  '/debug': (context) => BluetoothHomePage(),
      //},
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      //home: const BluetoothHomePage(),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/default');
//               },
//               child: Text('Go to User UI'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/debug');
//               },
//               child: Text('Go to Debug UI'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    DefaultPage(),
    const BluetoothHomePage(),
    CalendarTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bluetooth App'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure labels are always shown
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User UI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Debug',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Tab Content'),
    );
  }
}

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    double progress = 0.9;
    double countdown = 2.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Today\'s Progress',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20), // Add some space between the sections
            Text(
              'Next reminder in $countdown hours',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      print("Bluetooth not supported by this device");
      return;
    }

    // 监听蓝牙状态
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      setState(() {
        bluetoothState = state;
      });
      if (state == BluetoothAdapterState.on) {
        print("Bluetooth is ON");
      } else {
        print("Bluetooth is OFF or unavailable");
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please turn on Bluetooth'),
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
      connectionStatus = 'Connecting...';
    });

    // 监听设备断开连接事件
    var subscription = device.connectionState.listen((BluetoothConnectionState state) {
      if (state == BluetoothConnectionState.connected) {
        setState(() {
          connectionStatus = 'Successful Connect';
        });
        // 一旦连接成功，开始监听通知
        _listenForDataPackets(device);
      }
      if (state == BluetoothConnectionState.disconnected) {
        print("${device.disconnectReason?.code} ${device.disconnectReason?.description}");
        setState(() {
          connectionStatus = 'Disconnected';
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
    String hexString = dataPacket.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
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
      'Serial Number': dataPacket.sublist(2, 6).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(),
      'Power Status': dataPacket[6] == 1 ? 'On' : 'Off',
      'Temperature': ((dataPacket[7] << 8) | dataPacket[8]) / 10.0,
      'Weight': ((dataPacket[9] << 8) | dataPacket[10]) / 1.0,
      'Battery': dataPacket[12],
      'Reserved': dataPacket.sublist(13, 15).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(),
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
        title: const Text('Bluetooth Scanner'),
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
          Text(connectionStatus, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          const Text('Data Packets Received:'),
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
          const Text('Parsed Data:'),
          Expanded(
            child: ListView.builder(
              itemCount: parsedDataPackets.length,
              itemBuilder: (context, index) {
                final packet = parsedDataPackets[index];
                return ListTile(
                  title: Text('Packet ${index + 1}: Length=${packet['Length']}, Product Type=${packet['Product Type']}, Serial Number=${packet['Serial Number']}, Power Status=${packet['Power Status']}, Temperature=${packet['Temperature']}°C, Weight=${packet['Weight']}g, Battery=${packet['Battery']}, Reserved=${packet['Reserved']}, Checksum=${packet['Checksum']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DevicePage extends StatefulWidget {
  final BluetoothDevice device;
  final Function(List<int>) onDataPacketReceived;

  const DevicePage({super.key, required this.device, required this.onDataPacketReceived});

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  List<BluetoothService> services = [];

  @override
  void initState() {
    super.initState();
    _discoverServices();
  }

  void _discoverServices() async {
    services = await widget.device.discoverServices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.remoteId.toString()),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ExpansionTile(
            title: Text('Service UUID: ${service.uuid}'),
            children: service.characteristics.map((c) {
              return ListTile(
                title: Text('Characteristic UUID: ${c.uuid}'),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    var value = await c.read();
                    widget.onDataPacketReceived(value); // 传递字节数据
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
