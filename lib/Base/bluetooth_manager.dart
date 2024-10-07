import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';

class BluetoothManager {
  BluetoothManager._privateConstructor();

  static final BluetoothManager _instance = BluetoothManager._privateConstructor();
  static BluetoothManager get instance => _instance;

  BluetoothDevice? connectedDevice;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;
  ValueNotifier<String> connectionStatus = ValueNotifier('');
  ValueNotifier<List<Map<String, dynamic>>> parsedDataNotifier = ValueNotifier([]);
  ValueNotifier<bool> isScanning = ValueNotifier(false);

  Future<void> startScan() async {
    // Check Bluetooth state
    BluetoothAdapterState adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      connectionStatus.value = 'Bluetooth is not available or turned off.';
      return;
    }

    isScanning.value = true;
    parsedDataNotifier.value.clear();

    // Start scanning for devices
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty) {
          // Process scan results
          print('Found device: ${r.device.name}');
        }
      }
    });

    FlutterBluePlus.isScanning.listen((isScanning) {
      this.isScanning.value = isScanning;
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      connectionStatus.value = 'Connecting...';
      await _connectionStateSubscription?.cancel();

      _connectionStateSubscription = device.connectionState.listen((BluetoothConnectionState state) {
        if (state == BluetoothConnectionState.connected) {
          connectionStatus.value = 'Connected';
          connectedDevice = device;
          _listenForDataPackets(device);
        } else if (state == BluetoothConnectionState.disconnected) {
          connectionStatus.value = 'Disconnected';
          connectedDevice = null;
          _connectionStateSubscription?.cancel();
        }
      });

      await device.connect();
    } catch (e) {
      connectionStatus.value = 'Error connecting to device';
      print(e);
    }
  }

  Future<void> disconnectDevice() async {
    if (connectedDevice != null) {
      await connectedDevice?.disconnect();
      connectionStatus.value = 'Disconnected';
      connectedDevice = null;
    }
  }

  Future<void> _listenForDataPackets(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();

    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          await characteristic.setNotifyValue(true);
          characteristic.onValueReceived.listen((data) {
            parseDataPacket(data);
          });
        }
      }
    }
  }

  void parseDataPacket(List<int> dataPacket) {
    if (dataPacket.length >= 16) {
      Map<String, dynamic> parsedData = {
        'Length': dataPacket[0],
        'Product Type': dataPacket[1],
        'Serial Number': dataPacket.sublist(2, 6).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(),
        'Power Status': dataPacket[6] == 1 ? 'On' : 'Off',
        'Temperature': ((dataPacket[7] << 8) | dataPacket[8]) / 10.0,
        'Weight': ((dataPacket[9] << 8) | dataPacket[10]) / 1.0,
        'Battery': dataPacket[12],
      };

      parsedDataNotifier.value = [...parsedDataNotifier.value, parsedData];
    }
  }
}