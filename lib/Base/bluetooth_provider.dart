import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothProvider extends ChangeNotifier {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  BluetoothAdapterState _bluetoothState = BluetoothAdapterState.unknown;
  String _connectionStatus = '';
  List<Map<String, dynamic>> _parsedDataPackets = [];
  BluetoothDevice? _connectedDevice;

  // Getters
  List<ScanResult> get scanResults => _scanResults;
  bool get isScanning => _isScanning;
  BluetoothAdapterState get bluetoothState => _bluetoothState;
  String get connectionStatus => _connectionStatus;
  List<Map<String, dynamic>> get parsedDataPackets => _parsedDataPackets;
  BluetoothDevice? get connectedDevice => _connectedDevice;

  BluetoothProvider() {
    _checkBluetoothState();
  }

  void _checkBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      _bluetoothState = state;
      if (state == BluetoothAdapterState.on) {
        _connectionStatus = 'Bluetooth is on';
      } else {
        _connectionStatus = 'Bluetooth is ${state.toString().split('.').last}';
      }
      notifyListeners();
    });
  }

  void startScanning() async {
    _connectionStatus = 'Scanning...';
    _isScanning = true;
    notifyListeners();

    try {
      await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
      FlutterBluePlus.scanResults.listen((results) {
        _scanResults = results;
        notifyListeners();
      });
    } catch (e) {
      print('Error scanning: $e');
    }

    await Future.delayed(Duration(seconds: 4));
    await FlutterBluePlus.stopScan();
    _isScanning = false;
    _connectionStatus = 'Scan completed';
    notifyListeners();
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      _connectionStatus = 'Connecting...';
      notifyListeners();

      await device.connect();
      _connectedDevice = device;
      _connectionStatus = 'Connected to ${device.remoteId}';
      notifyListeners();

      _listenForDataPackets(device);
    } catch (e) {
      _connectionStatus = 'Connection failed: $e';
      notifyListeners();
    }
  }

  void _listenForDataPackets(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.notify) {
          await characteristic.setNotifyValue(true);
          characteristic.value.listen((value) {
            _parseDataPacket(value);
          });
        }
      }
    }
  }

  void _parseDataPacket(List<int> dataPacket) {
    if (dataPacket.length >= 16) { // Ensure enough data is present
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

      _parsedDataPackets.add(parsedData);
      notifyListeners(); // Notify listeners about the new parsed data
    }
  }

  void disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      _parsedDataPackets.clear();
      _connectionStatus = 'Disconnected';
      notifyListeners();
    }
  }
}
