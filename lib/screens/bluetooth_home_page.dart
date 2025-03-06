import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Base/bluetooth_provider.dart';
import 'dart:math';

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
                      : ModernWaveUI(
                    latestPacket: bluetoothProvider.parsedDataPackets.isNotEmpty
                        ? bluetoothProvider.parsedDataPackets.last
                        : null,
                    previousPacket: bluetoothProvider.parsedDataPackets.length > 1
                        ? bluetoothProvider.parsedDataPackets[bluetoothProvider.parsedDataPackets.length - 2]
                        : null,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: bluetoothProvider.connectedDevice != null
              ? FloatingActionButton(
            onPressed: bluetoothProvider.disconnectDevice,
            backgroundColor: Colors.blue,
            child: Icon(Icons.bluetooth_disabled),
            tooltip: 'Disconnect',
          )
              : null,
        );
      },
    );
  }

  Widget _buildInitialUI(BuildContext context, BluetoothProvider provider) {
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
}class ModernWaveUI extends StatelessWidget {
  final Map<String, dynamic>? latestPacket;
  final Map<String, dynamic>? previousPacket;

  const ModernWaveUI({
    Key? key,
    this.latestPacket,
    this.previousPacket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNotificationBar(),
        Expanded(
          child: _buildMainCircle(),
        ),
      ],
    );
  }

  Widget _buildNotificationBar() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.water_drop, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time to drink water • now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Stay hydrated by drinking water!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildMainCircle() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 340,
            height: 340,
            child: Stack(
              alignment: Alignment.center,
              children: [
                WaterDropContainer(
                  size: 280,
                  weight: latestPacket?['Weight'] ?? 0,
                  maxWeight: 1000,
                ),
                ..._buildSatelliteButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSatelliteButtons() {
    final buttonData = [
      {
        'icon': Icons.battery_full,
        'value': '${latestPacket?['Battery']?.toString() ?? ''}%',
        'previousValue': '${previousPacket?['Battery']?.toString()}%',
        'label': 'Battery',
        'angle': -pi/2
      },
      {
        'icon': Icons.water_drop,
        'value': '${latestPacket?['Product Type']?.toString() ?? ''}',
        'previousValue': previousPacket?['Product Type']?.toString(),
        'label': 'Type',
        'angle': 0.0
      },
      {
        'icon': Icons.key,
        'value': '${latestPacket?['Serial Number']?.toString() ?? ''}',
        'previousValue': previousPacket?['Serial Number']?.toString(),
        'label': 'Serial',
        'angle': pi/2
      },
      {
        'icon': Icons.power_settings_new,
        'value': 'On',
        'previousValue': 'On',
        'label': 'Power',
        'angle': pi
      },
    ];

    return buttonData.map((data) {
      final angle = data['angle'] as double;
      final radius = 160.0;
      final x = radius * cos(angle);
      final y = radius * sin(angle);

      return Transform.translate(
        offset: Offset(x, y),
        child: SatelliteButton(
          icon: data['icon'] as IconData,
          value: data['value'] as String,
          previousValue: data['previousValue'] as String?,
          label: data['label'] as String,
        ),
      );
    }).toList();
  }
}class WaterDropContainer extends StatefulWidget {
  final double size;
  final double weight;
  final double maxWeight;

  const WaterDropContainer({
    required this.size,
    required this.weight,
    required this.maxWeight,
  });

  @override
  _WaterDropContainerState createState() => _WaterDropContainerState();
}

class _WaterDropContainerState extends State<WaterDropContainer> with TickerProviderStateMixin {
  late AnimationController waveController;
  late AnimationController dropController;
  late Animation<double> dropAnimation;
  List<WaterDrop> waterDrops = [];

  @override
  void initState() {
    super.initState();
    waveController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    dropController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    dropAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: dropController, curve: Curves.easeInOut),
    );
  }

  void addWaterDrop() {
    if (waterDrops.length < 5) {
      setState(() {
        waterDrops.add(WaterDrop(
          startPosition: Offset(widget.size * 0.5, widget.size * 0.2),
          endPosition: Offset(widget.size * 0.5, widget.size * 0.7),
        ));
      });
    }
  }

  @override
  void didUpdateWidget(WaterDropContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.weight != oldWidget.weight) {
      addWaterDrop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fillPercentage = (widget.weight / widget.maxWeight).clamp(0.0, 1.0);

    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade50,
              border: Border.all(
                color: Colors.blue.shade100,
                width: 2,
              ),
            ),
          ),
          ClipOval(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: waveController,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        CustomPaint(
                          painter: CircularWavePainter(
                            animation: waveController,
                            fillPercentage: fillPercentage,
                            waveColor: Colors.blue.shade600.withOpacity(0.4),
                            frequency: 3.5,
                            amplitude: 0.15,
                          ),
                          size: Size(widget.size, widget.size),
                        ),
                        CustomPaint(
                          painter: CircularWavePainter(
                            animation: waveController,
                            fillPercentage: fillPercentage,
                            waveColor: Colors.blue.shade700.withOpacity(0.3),
                            frequency: 4.0,
                            phase: pi,
                            amplitude: 0.15,
                          ),
                          size: Size(widget.size, widget.size),
                        ),
                      ],
                    );
                  },
                ),
                ...waterDrops.map((drop) => buildWaterDrop(drop)).toList(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.weight.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'g',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWaterDrop(WaterDrop drop) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: drop.startPosition, end: drop.endPosition),
      duration: Duration(milliseconds: 1500),
      onEnd: () {
        setState(() {
          waterDrops.remove(drop);
        });
      },
      builder: (context, offset, child) {
        return Positioned(
          left: offset.dx - 10,
          top: offset.dy - 10,
          child: Icon(
            Icons.water_drop,
            color: Colors.blue.withOpacity(0.6),
            size: 20,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    waveController.dispose();
    dropController.dispose();
    super.dispose();
  }
}

class CircularWavePainter extends CustomPainter {
  final Animation<double> animation;
  final double fillPercentage;
  final Color waveColor;
  final double frequency;
  final double phase;
  final double amplitude;

  CircularWavePainter({
    required this.animation,
    required this.fillPercentage,
    required this.waveColor,
    this.frequency = 1.0,
    this.phase = 0.0,
    this.amplitude = 0.05,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.fill;

    final path = Path();
    final baseHeight = size.height * (1 - fillPercentage);
    final waveHeight = size.height * amplitude;

    path.moveTo(0, size.height);

    for (var i = 0.0; i <= size.width; i++) {
      final x = i;
      final y = baseHeight +
          sin((x * frequency / size.width * 2 * pi) +
              (animation.value * 2 * pi) + phase) * waveHeight;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.save();
    final clipPath = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.clipPath(clipPath);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CircularWavePainter oldDelegate) => true;
}

class WaterDrop {
  final Offset startPosition;
  final Offset endPosition;

  WaterDrop({
    required this.startPosition,
    required this.endPosition,
  });
}

class SatelliteButton extends StatefulWidget {
  final IconData icon;
  final String value;
  final String? previousValue;
  final String label;

  const SatelliteButton({
    Key? key,
    required this.icon,
    required this.value,
    required this.label,
    this.previousValue,
  }) : super(key: key);

  @override
  _SatelliteButtonState createState() => _SatelliteButtonState();
}

class _SatelliteButtonState extends State<SatelliteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(SatelliteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.blue.shade400, size: 24),
            SizedBox(height: 4),
            Text(
              widget.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}