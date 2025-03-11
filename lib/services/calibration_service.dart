import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class CalibrationService {
  static const String _calibrationDataKey = 'calibration_data';
  static const String _multiDeviceCalibrationKey = 'multi_device_calibration_enabled';
  
  // 默认为false，表示一个用户只能校准一个设备
  static bool _multiDeviceCalibrationEnabled = true;
  
  // 初始化校准设置
  Future<void> initializeCalibrationSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // 检查是否已经初始化过校准设置
      final bool hasInitialized = prefs.getBool('has_initialized_calibration') ?? false;
      
      if (!hasInitialized) {
        // 初始化多设备校准设置（默认为false）
        await prefs.setBool(_multiDeviceCalibrationKey, false);
        await prefs.setBool('has_initialized_calibration', true);
      }
      
      // 加载多设备校准设置
      _multiDeviceCalibrationEnabled = prefs.getBool(_multiDeviceCalibrationKey) ?? false;
    } catch (e) {
      print('初始化校准设置失败: $e');
    }
  }
  
  // 获取多设备校准设置状态
  bool isMultiDeviceCalibrationEnabled() {
    return _multiDeviceCalibrationEnabled;
  }
  
  // 设置多设备校准状态
  Future<bool> setMultiDeviceCalibrationEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _multiDeviceCalibrationEnabled = enabled;
      return await prefs.setBool(_multiDeviceCalibrationKey, enabled);
    } catch (e) {
      print('设置多设备校准状态失败: $e');
      return false;
    }
  }

  // 保存校准数据
  Future<bool> saveCalibration(String deviceId, double calibrationValue, {String? deviceName}) async {
    try {
      // 获取当前登录用户
      final User? currentUser = await AuthService.getCurrentUser();
      if (currentUser == null) {
        print('保存校准数据失败: 用户未登录');
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> calibrationData = json.decode(calibrationDataJson);
      
      // 如果不允许多设备校准，则清除该用户之前的所有校准数据
      if (!_multiDeviceCalibrationEnabled) {
        // 移除该用户之前的所有校准数据
        calibrationData.removeWhere((key, value) => 
          value['userId'] == currentUser.username);
      }
      
      // 使用复合键（设备ID+用户ID）作为存储键，确保不同用户的校准数据不会相互覆盖
      final String compositeKey = '${deviceId}_${currentUser.username}';
      
      // 添加新的校准数据，包含用户ID和设备ID
      calibrationData[compositeKey] = {
        'value': calibrationValue,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'deviceName': deviceName,
        'userId': currentUser.username,
        'deviceId': deviceId
      };
      
      await prefs.setString(_calibrationDataKey, json.encode(calibrationData));
      return true;
    } catch (e) {
      print('保存校准数据失败: $e');
      return false;
    }
  }

  // 获取指定设备的校准数据
  Future<Map<String, dynamic>?> getCalibrationForDevice(String deviceId) async {
    try {
      // 获取当前登录用户
      final User? currentUser = await AuthService.getCurrentUser();
      if (currentUser == null) {
        print('获取校准数据失败: 用户未登录');
        return null;
      }

      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> calibrationData = json.decode(calibrationDataJson);

      // 使用复合键（设备ID+用户ID）查找校准数据
      final String compositeKey = '${deviceId}_${currentUser.username}';
      final deviceData = calibrationData[compositeKey];
      
      return deviceData;
    } catch (e) {
      print('获取校准数据失败: $e');
      return null;
    }
  }

  // 获取所有校准数据
  Future<Map<String, dynamic>> getAllCalibrations() async {
    try {
      // 获取当前登录用户
      final User? currentUser = await AuthService.getCurrentUser();
      if (currentUser == null) {
        print('获取所有校准数据失败: 用户未登录');
        return {};
      }

      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> allData = json.decode(calibrationDataJson);
      
      // 只返回属于当前用户的校准数据
      final Map<String, dynamic> userCalibrations = {};
      allData.forEach((key, data) {
        if (data['userId'] == currentUser.username) {
          // 使用设备ID作为键，方便前端显示
          final String deviceId = data['deviceId'];
          userCalibrations[deviceId] = data;
        }
      });
      return userCalibrations;
    } catch (e) {
      print('获取所有校准数据失败: $e');
      return {};
    }
  }

  // 删除指定设备的校准数据
  Future<bool> deleteCalibration(String deviceId) async {
    try {
      // 获取当前登录用户
      final User? currentUser = await AuthService.getCurrentUser();
      if (currentUser == null) {
        print('删除校准数据失败: 用户未登录');
        return false;
      }
      
      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> calibrationData = json.decode(calibrationDataJson);
      
      // 使用复合键（设备ID+用户ID）查找并删除校准数据
      final String compositeKey = '${deviceId}_${currentUser.username}';
      if (calibrationData.containsKey(compositeKey)) {
        calibrationData.remove(compositeKey);
        await prefs.setString(_calibrationDataKey, json.encode(calibrationData));
        return true;
      }
      return false;
    } catch (e) {
      print('删除校准数据失败: $e');
      return false;
    }
  }

  // 检查设备是否已校准
  Future<bool> isDeviceCalibrated(String deviceId) async {
    final calibration = await getCalibrationForDevice(deviceId);
    return calibration != null;
  }

  // 获取校准值
  Future<double?> getCalibrationValue(String deviceId) async {
    final calibration = await getCalibrationForDevice(deviceId);
    return calibration != null ? calibration['value'] : null;
  }

  // 格式化校准时间
  String formatCalibrationTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}