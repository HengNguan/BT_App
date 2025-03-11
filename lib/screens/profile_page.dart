import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Base/bluetooth_provider.dart';
import '../Constant/ConstantStyling.dart';
import '../generated/l10n.dart';
import '../services/auth_service.dart';
import '../services/calibration_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onLogout;

  const ProfilePage({Key? key, this.onLogout}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _currentUser;
  bool _isLoading = false;
  Map<String, dynamic> _calibratedDevices = {};
  final CalibrationService _calibrationService = CalibrationService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadCalibratedDevices();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    final user = await AuthService.getCurrentUser();
    if (mounted) {
      setState(() {
        _currentUser = user;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCalibratedDevices() async {
    final calibrations = await _calibrationService.getAllCalibrations();
    if (mounted) {
      setState(() {
        _calibratedDevices = calibrations;
      });
    }
  }

  // 改进的注销方法
  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 获取当前的BluetoothProvider实例
      final bluetoothProvider = Provider.of<BluetoothProvider>(context, listen: false);
      
      // 确保完全清除用户状态，并传递BluetoothProvider实例以断开蓝牙连接
      await AuthService.logout(bluetoothProvider: bluetoothProvider);

      if (mounted) {
        setState(() {
          _currentUser = null;
          _isLoading = false;
        });
      }

      // 处理注销后的导航逻辑
      if (widget.onLogout != null) {
        widget.onLogout!();
      } else {
        // 确保清除整个导航堆栈，并传入 checkCurrentUser: false 以防止自动登录
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage(checkCurrentUser: false)),
                (route) => false,
          );
        }
      }
    } catch (e) {
      debugPrint('注销过程中发生错误: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('注销失败: ${e.toString()}')),
        );
      }
    }
  }

  // 解绑设备
  Future<void> _unbindDevice(String deviceId) async {
    if (_currentUser == null) return;

    setState(() {
      _isLoading = true;
    });

    final success = await AuthService.unbindDeviceFromUser(_currentUser!.username, deviceId);

    if (success) {
      // 重新加载用户数据
      await _loadUserData();

      // 如果设备已校准，询问是否也要删除校准数据
      final isCalibrated = await _calibrationService.isDeviceCalibrated(deviceId);
      if (isCalibrated) {
        _showDeleteCalibrationDialog(deviceId);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).unbindDeviceSuccess)),
        );
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).unbindDeviceFailed)),
        );
      }
    }
  }

  // 显示删除校准数据的确认对话框
  void _showDeleteCalibrationDialog(String deviceId) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirmDelete),
        content: Text(S.of(context).confirmDeleteCalibrationData),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _isLoading = false;
              });
            },
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _calibrationService.deleteCalibration(deviceId);
              await _loadCalibratedDevices();
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).calibrationDeleted)),
                );
              }
            },
            child: Text(S.of(context).delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildProfileContent(),
    );
  }

  Widget _buildProfileContent() {
    if (_currentUser == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              S.of(context).notLoggedIn,
              style: AppTextStyles.medium18,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E7CFF),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                S.of(context).login,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24),
          // 用户头像
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2E7CFF).withOpacity(0.1),
              border: Border.all(color: Color(0xFF2E7CFF), width: 2),
            ),
            child: Icon(
              Icons.account_circle,
              size: 80,
              color: Color(0xFF2E7CFF),
            ),
          ),
          SizedBox(height: 16),
          // 用户名
          Text(
            _currentUser!.displayName,
            style: AppTextStyles.bold24,
          ),
          SizedBox(height: 8),
          // 用户账号
          Text(
            _currentUser!.username,
            style: AppTextStyles.regular16.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 32),

          // 用户绑定设备卡片 - 新增
          if (_currentUser!.boundDeviceIds.isNotEmpty) ...[
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bluetooth_connected, color: Color(0xFF2E7CFF)),
                        SizedBox(width: 8),
                        Text(
                          "绑定的设备",
                          style: AppTextStyles.medium18,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Column(
                      children: _currentUser!.boundDeviceIds.map((deviceId) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.devices, color: Color(0xFF2E7CFF)),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "设备 ID",
                                        style: AppTextStyles.regular14.copyWith(color: Colors.grey),
                                      ),
                                      Text(
                                        deviceId,
                                        style: AppTextStyles.regular16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.link_off, color: Colors.red),
                                  onPressed: () => _unbindDevice(deviceId),
                                  tooltip: S.of(context).unbindDevice,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],

          // 已校准设备卡片
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings_applications, color: Color(0xFF2E7CFF)),
                      SizedBox(width: 8),
                      Text(
                        S.of(context).calibrationHistory,
                        style: AppTextStyles.medium18,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _calibratedDevices.isEmpty
                      ? Text(
                    S.of(context).noCalibrationHistory,
                    style: AppTextStyles.regular16.copyWith(color: Colors.grey),
                  )
                      : Column(
                    children: _calibratedDevices.entries.map((entry) {
                      final deviceId = entry.key;
                      final calibrationData = entry.value;
                      final calibrationValue = calibrationData['value']?.toString() ?? '0.0';
                      final timestamp = calibrationData['timestamp'] ?? 0;
                      final deviceName = calibrationData['deviceName'] ?? deviceId;
                      final formattedDate = _calibrationService.formatCalibrationTime(timestamp);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      deviceName,
                                      style: AppTextStyles.regular16.copyWith(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '$calibrationValue g',
                                    style: AppTextStyles.regular16.copyWith(color: Color(0xFF2E7CFF)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: AppTextStyles.regular12.copyWith(color: Colors.grey),
                              ),
                              Text(
                                deviceId,
                                style: AppTextStyles.regular10.copyWith(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 48),
          // 登出按钮
          ElevatedButton.icon(
            onPressed: _logout,
            icon: Icon(Icons.logout),
            label: Text(S.of(context).logout),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}