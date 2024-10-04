import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DevicePage extends StatefulWidget {
  final BluetoothDevice device;
  final Function(List<int>) onDataPacketReceived;

  const DevicePage(
      {super.key, required this.device, required this.onDataPacketReceived});

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
