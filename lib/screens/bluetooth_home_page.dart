import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Base/bluetooth_provider.dart';
import 'dart:math';
import '../widgets/language_switch_button.dart';
import '../widgets/calibration_widget.dart';
import '../generated/l10n.dart';

class BluetoothHomePage extends StatelessWidget {
  const BluetoothHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothProvider>(
      builder: (context, bluetoothProvider, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF2F7FF),
                  Color(0xFFE6F0FF),
                ],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: bluetoothProvider.connectedDevice == null
                        ? _buildInitialUI(context, bluetoothProvider)
                        : DeviceDetailUI(
                      latestPacket: bluetoothProvider.parsedDataPackets.isNotEmpty
                          ? bluetoothProvider.parsedDataPackets.last
                          : null,
                      previousPacket: bluetoothProvider.parsedDataPackets.length > 1
                          ? bluetoothProvider.parsedDataPackets[bluetoothProvider.parsedDataPackets.length - 2]
                          : null,
                    ),
                  ),
                  // Language switcher positioned at top-right
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: LanguageSwitchButton(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: bluetoothProvider.connectedDevice != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 校准功能组件
                      CalibrationWidget(),
                      SizedBox(width: 8),
                      // 断开连接按钮
                      FloatingActionButton(
                        onPressed: bluetoothProvider.disconnectDevice,
                        backgroundColor: Color(0xFF2E7CFF),
                        child: Icon(Icons.bluetooth_disabled, color: Colors.white),
                        tooltip: S.of(context).disconnect,
                      ),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _buildInitialUI(BuildContext context, BluetoothProvider provider) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40), // Extra space to account for language switcher
                Text(
                  S.of(context).bluetoothScanner,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7CFF),
                  ),
                ),
                SizedBox(height: 20),
                // Scan button with icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.bluetooth,
                      size: 30,
                      color: Color(0xFF2E7CFF),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Scan button
                Container(
                  width: 220,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: provider.isScanning ? null : provider.startScanning,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E7CFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (provider.isScanning)
                          Container(
                            width: 18,
                            height: 18,
                            margin: EdgeInsets.only(right: 10),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        Text(
                          provider.isScanning ? S.of(context).scanning : S.of(context).scanForDevices,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14),
                // Status text
                Text(
                  provider.connectionStatus,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5A6B87),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        if (provider.scanResults.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                S.of(context).availableDevices,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7CFF),
                ),
              ),
            ),
          ),
        if (provider.scanResults.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final result = provider.scanResults[index];
                final device = result.device;
                final deviceName = result.advertisementData.localName.isNotEmpty
                    ? result.advertisementData.localName
                    : S.of(context).unknownDevice;

                // Determine device type by name
                IconData iconData = Icons.bluetooth;

                if (deviceName.toLowerCase().contains('headphone') ||
                    deviceName.toLowerCase().contains('earphone') ||
                    deviceName.toLowerCase().contains('buds') ||
                    deviceName.toLowerCase().contains('airpods')) {
                  iconData = Icons.headphones;
                } else if (deviceName.toLowerCase().contains('watch') ||
                    deviceName.toLowerCase().contains('band')) {
                  iconData = Icons.watch;
                } else if (deviceName.toLowerCase().contains('speaker') ||
                    deviceName.toLowerCase().contains('soundbar')) {
                  iconData = Icons.speaker;
                } else if (deviceName.toLowerCase().contains('tv') ||
                    deviceName.toLowerCase().contains('screen')) {
                  iconData = Icons.tv;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Color(0xFFE6F0FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              iconData,
                              color: Color(0xFF2E7CFF),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deviceName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  device.remoteId.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () => provider.connectToDevice(device),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2E7CFF),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                S.of(context).connect,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: provider.scanResults.length,
            ),
          ),
        // Add bottom padding to avoid fab overlap
        SliverToBoxAdapter(
          child: SizedBox(height: 80),
        ),
      ],
    );
  }
}

class DeviceDetailUI extends StatelessWidget {
  final Map<String, dynamic>? latestPacket;
  final Map<String, dynamic>? previousPacket;

  const DeviceDetailUI({
    Key? key,
    this.latestPacket,
    this.previousPacket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add top padding for language switcher
        SizedBox(height: 50),
        // Title
        Text(
          S.of(context).connectedDevice,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7CFF),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _buildMainCircle(context),
                  SizedBox(height: 30),
                  _buildInfoCards(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainCircle(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: WaterDropContainer(
        size: 280,
        weight: latestPacket?['Weight'] ?? 0,
        maxWeight: 1000,
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return Column(
      children: [
        _buildInfoRow(
          context,
          [
            _buildInfoCard(
              icon: Icons.battery_full,
              title: S.of(context).battery,
              value: '${latestPacket?['Battery']?.toString() ?? '0'}%',
              color: Colors.green[100]!,
              iconColor: Colors.green,
            ),
            _buildInfoCard(
              icon: Icons.power_settings_new,
              title: S.of(context).power,
              value: S.of(context).on,
              color: Colors.blue[50]!,
              iconColor: Color(0xFF2E7CFF),
            ),
          ],
        ),
        SizedBox(height: 15),
        _buildInfoRow(
          context,
          [
            _buildInfoCard(
              icon: Icons.water_drop,
              title: S.of(context).type,
              value: '${latestPacket?['Product Type']?.toString() ?? 'Standard'}',
              color: Colors.blue[50]!,
              iconColor: Color(0xFF2E7CFF),
            ),
            _buildInfoCard(
              icon: Icons.key,
              title: S.of(context).serial,
              value: '${latestPacket?['Serial Number']?.toString() ?? 'Unknown'}',
              color: Colors.blue[50]!,
              iconColor: Color(0xFF2E7CFF),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, List<Widget> children) {
    return Row(
      children: children.map((child) {
        return Expanded(child: child);
      }).toList(),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaterDropContainer extends StatefulWidget {
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
      duration: Duration(seconds: 4),  // Slower wave animation for subtlety
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
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF2E7CFF).withOpacity(0.2),
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
                            waveColor: Color(0xFF2E7CFF).withOpacity(0.3),
                            frequency: 1.5,  // Less frequent waves (more gentle)
                            amplitude: 0.03,  // Much smaller amplitude for subtle effect
                          ),
                          size: Size(widget.size, widget.size),
                        ),
                        CustomPaint(
                          painter: CircularWavePainter(
                            animation: waveController,
                            fillPercentage: fillPercentage,
                            waveColor: Color(0xFF2E7CFF).withOpacity(0.2),
                            frequency: 2.0,
                            phase: pi / 2,  // Offset the waves so they don't stack
                            amplitude: 0.02,  // Even smaller for the second wave
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
                          color: Color(0xFF2E7CFF),
                        ),
                      ),
                      Text(
                        'g',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF2E7CFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // No plus button
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
            color: Color(0xFF2E7CFF).withOpacity(0.6),
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

    // Determine wave position based on fill percentage
    final baseHeight = size.height * (1 - fillPercentage);

    // Use a more subtle wave animation with reduced amplitude
    final waveHeight = size.height * amplitude;

    final path = Path();

    // Start from the bottom left of the circle
    path.moveTo(0, size.height);

    // Create a smoother, more subtle wave pattern
    for (var i = 0.0; i <= size.width; i++) {
      final x = i;
      final normalizedX = x / size.width;

      // Create a smoother wave pattern with less dramatic peaks
      final y = baseHeight +
          sin((normalizedX * frequency * 2 * pi) +
              (animation.value * 2 * pi) + phase) * waveHeight;

      path.lineTo(x, y);
    }

    // Complete the path back to the bottom
    path.lineTo(size.width, size.height);
    path.close();

    canvas.save();
    // Make sure to clip to the circle
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