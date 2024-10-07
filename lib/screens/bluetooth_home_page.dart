import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Base/bluetooth_provider.dart';
import '../generated/l10n.dart';
import '../widgets/info_card.dart';

class BluetoothHomePage extends StatelessWidget {
  const BluetoothHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(
      builder: (context, bluetoothProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/water_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: bluetoothProvider.connectedDevice == null
                      ? _buildInitialUI(context, bluetoothProvider)
                      : _buildParsedDataUI(bluetoothProvider),
                ),
              ),
            ],
          ),
          floatingActionButton: bluetoothProvider.connectedDevice != null
              ? FloatingActionButton(
            onPressed: bluetoothProvider.disconnectDevice,
            child: Icon(Icons.bluetooth_disabled),
            tooltip: 'Disconnect',
          )
              : null,
        );
      },
    );
  }

  Widget _buildInitialUI(BuildContext context, BluetoothProvider provider) {
    // This remains the same as your current implementation
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: provider.isScanning ? null : provider.startScanning,
          child: Text(provider.isScanning ? 'Scanning...' : 'Scan for Devices'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
        Text(provider.connectionStatus,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (provider.scanResults.isNotEmpty) ...[
          SizedBox(height: 20),
          _buildWaterBottle(),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: provider.scanResults.length,
              itemBuilder: (context, index) {
                final result = provider.scanResults[index];
                final device = result.device;
                final deviceName = result.advertisementData.localName.isNotEmpty
                    ? result.advertisementData.localName
                    : 'Unknown Device';

                return ListTile(
                  title: Text(deviceName),
                  subtitle: Text('ID: ${device.remoteId}'),
                  trailing: ElevatedButton(
                    onPressed: () => provider.connectToDevice(device),
                    child: Text('Connect'),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildParsedDataUI(BluetoothProvider provider) {
    final latestPacket = provider.parsedDataPackets.isNotEmpty
        ? provider.parsedDataPackets.last
        : null;

    return Column(
      children: [
        Spacer(),
        _buildWaterBottle(),
        SizedBox(height: 20),
        if (latestPacket != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoCard(
                title: 'Weight',
                value: '${latestPacket['Weight']}g',
              ),
              InfoCard(
                title: 'Temperature',
                value: '${latestPacket['Temperature']}°C',
              ),
              InfoCard(
                title: 'Serial Number',
                value: '${latestPacket['Serial Number']}',
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoCard(
                title: 'Battery',
                value: '${latestPacket['Battery']}',
              ),
              InfoCard(
                title: 'Power Status',
                value: '${latestPacket['Power Status']}',
              ),
              InfoCard(
                title: 'Product Type',
                value: '${latestPacket['Product Type']}',
              ),
            ],
          ),
        ],
        Spacer(),
      ],
    );
  }

  Widget _buildWaterBottle() {
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 96,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}