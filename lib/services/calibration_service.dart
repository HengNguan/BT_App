import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CalibrationService {
  static const String _calibrationDataKey = 'calibration_data';

  // 保存校准数据
  Future<bool> saveCalibration(String deviceId, double calibrationValue, {String? deviceName}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> calibrationData = json.decode(calibrationDataJson);
      
      calibrationData[deviceId] = {
        'value': calibrationValue,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'deviceName': deviceName,
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
      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> calibrationData = json.decode(calibrationDataJson);
      
      return calibrationData[deviceId];
    } catch (e) {
      print('获取校准数据失败: $e');
      return null;
    }
  }

  // 获取所有校准数据
  Future<Map<String, dynamic>> getAllCalibrations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      return json.decode(calibrationDataJson);
    } catch (e) {
      print('获取所有校准数据失败: $e');
      return {};
    }
  }

  // 删除指定设备的校准数据
  Future<bool> deleteCalibration(String deviceId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final calibrationDataJson = prefs.getString(_calibrationDataKey) ?? '{}';
      final Map<String, dynamic> calibrationData = json.decode(calibrationDataJson);
      
      if (calibrationData.containsKey(deviceId)) {
        calibrationData.remove(deviceId);
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