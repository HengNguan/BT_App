import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Base/bluetooth_provider.dart';

import '../generated/l10n.dart';

class User {
  final String username;
  final String password;
  final String displayName;
  List<String> boundDeviceIds = []; // 支持多设备绑定

  User({
    required this.username,
    required this.password,
    required this.displayName,
    List<String>? boundDeviceIds,
  }) {
    // 如果提供了设备ID列表，则使用它
    if (boundDeviceIds != null) {
      this.boundDeviceIds = boundDeviceIds;
    }
  }

  // 从JSON转换为User对象
  factory User.fromJson(Map<String, dynamic> json) {
    // 处理设备ID列表
    List<String> deviceIds = [];
    if (json['boundDeviceIds'] != null) {
      deviceIds = List<String>.from(json['boundDeviceIds']);
    }

    return User(
      username: json['username'],
      password: json['password'],
      displayName: json['displayName'],
      boundDeviceIds: deviceIds,
    );
  }

  // 将User对象转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'displayName': displayName,
      'boundDeviceIds': boundDeviceIds,
    };
  }
}

class AuthService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';
  static const String _multiDeviceBindingKey = 'multi_device_binding_enabled';

  // 多设备绑定设置，默认为true
  static bool _multiDeviceBindingEnabled = true;

  // 缓存SharedPreferences实例
  static SharedPreferences? _prefsInstance;

  // 默认用户列表
  static final List<User> _defaultUsers = [
    User(username: 'john', password: 'thebest', displayName: 'John'),
    User(username: 'leo', password: 'thebest', displayName: 'Leo'),
    User(username: 'mary', password: 'thebest', displayName: 'Mary'),
  ];

  // 安全获取SharedPreferences实例
  static Future<SharedPreferences?> _getPrefs() async {
    // 如果已经有实例，直接返回
    if (_prefsInstance != null) {
      return _prefsInstance;
    }

    try {
      // 尝试获取新实例，带超时处理
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(seconds: 2), onTimeout: () {
        throw TimeoutException('SharedPreferences获取超时');
      });

      _prefsInstance = prefs; // 保存成功的实例
      return prefs;
    } catch (e) {
      debugPrint('获取SharedPreferences错误: ${e.toString()}');
      return null;
    }
  }

  // 初始化用户数据
  static Future<void> initializeUsers() async {
    final prefs = await _getPrefs();
    if (prefs == null) return;

    // 检查是否已经初始化过用户
    final bool hasInitialized = prefs.getBool('has_initialized_users') ?? false;
    if (!hasInitialized) {
      // 将默认用户列表转换为JSON字符串列表
      final List<String> userJsonList = _defaultUsers.map((user) => jsonEncode(user.toJson())).toList();

      // 保存用户列表
      await prefs.setStringList(_usersKey, userJsonList);
      await prefs.setBool('has_initialized_users', true);

      // 初始化多设备绑定设置（默认为true）
      await prefs.setBool(_multiDeviceBindingKey, true);

      debugPrint('默认用户已初始化');
      // 打印初始化的用户数据进行调试
      for (var userJson in userJsonList) {
        debugPrint('初始化用户: $userJson');
      }
    }

    // 加载多设备绑定设置
    _multiDeviceBindingEnabled = prefs.getBool(_multiDeviceBindingKey) ?? true;
  }

  // 获取所有用户
  static Future<List<User>> getUsers() async {
    final prefs = await _getPrefs();
    if (prefs == null) return [];

    final List<String>? userJsonList = prefs.getStringList(_usersKey);
    if (userJsonList == null || userJsonList.isEmpty) {
      return [];
    }

    // 将JSON字符串列表转换为User对象列表
    return userJsonList.map((userJson) {
      try {
        // 解析JSON字符串为Map
        final Map<String, dynamic> userMap = Map<String, dynamic>.from(jsonDecode(userJson));
        return User.fromJson(userMap);
      } catch (e) {
        debugPrint('解析用户JSON出错: $e');
        return null;
      }
    }).whereType<User>().toList();
  }

  // 用户登录
  static Future<User?> login(String username, String password) async {
    final List<User> users = await getUsers();

    // 查找匹配的用户
    for (var user in users) {
      if (user.username == username && user.password == password) {
        // 保存当前登录用户
        await _saveCurrentUser(user);
        return user;
      }
    }

    return null; // 登录失败
  }

  // 保存当前登录用户
  static Future<void> _saveCurrentUser(User user) async {
    final prefs = await _getPrefs();
    if (prefs == null) return;

    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
  }

  // 获取当前登录用户
  static Future<User?> getCurrentUser() async {
    final prefs = await _getPrefs();
    if (prefs == null) return null;

    final String? userJson = prefs.getString(_currentUserKey);
    if (userJson == null || userJson.isEmpty) {
      return null;
    }

    try {
      final Map<String, dynamic> userMap = Map<String, dynamic>.from(jsonDecode(userJson));
      return User.fromJson(userMap);
    } catch (e) {
      debugPrint('解析当前用户JSON出错: $e');
      return null;
    }
  }

  // 用户登出 - 改进的登出方法
  static Future<void> logout({BluetoothProvider? bluetoothProvider}) async {
    final prefs = await _getPrefs();
    if (prefs == null) return;

    // 断开蓝牙连接
    // 如果提供了BluetoothProvider实例，使用它；否则创建一个新实例
    // 注意：在实际使用时，应该从外部传入已存在的BluetoothProvider实例
    final provider = bluetoothProvider ?? BluetoothProvider();
    await provider.disconnectDevice();

    // 删除当前用户信息
    await prefs.remove(_currentUserKey);

    // 清除登录状态的其他可能存储
    debugPrint('用户已成功登出，蓝牙设备已断开连接');
  }

  // 获取多设备绑定设置状态
  static bool isMultiDeviceBindingEnabled() {
    return _multiDeviceBindingEnabled;
  }

  // 设置多设备绑定状态
  static Future<bool> setMultiDeviceBindingEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    if (prefs == null) return false;

    _multiDeviceBindingEnabled = enabled;
    return await prefs.setBool(_multiDeviceBindingKey, enabled);
  }

  // 绑定设备到用户
  static Future<bool> bindDeviceToUser(String username, String deviceId) async {
    final prefs = await _getPrefs();
    if (prefs == null) return false;

    final List<String>? userJsonList = prefs.getStringList(_usersKey);
    if (userJsonList == null || userJsonList.isEmpty) {
      return false;
    }

    List<User> users = [];
    for (var userJson in userJsonList) {
      try {
        final Map<String, dynamic> userMap = Map<String, dynamic>.from(jsonDecode(userJson));
        users.add(User.fromJson(userMap));
      } catch (e) {
        debugPrint('在bindDeviceToUser中解析用户JSON出错: $e');
      }
    }

    // 检查设备是否已被其他用户绑定
    final User? boundUser = await getUserByDeviceId(deviceId);
    if (boundUser != null && boundUser.username != username) {
      return false; // 设备已被其他用户绑定
    }

    // 查找用户并更新设备ID
    bool found = false;
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == username) {
        // 检查设备是否已经绑定到该用户
        if (users[i].boundDeviceIds.contains(deviceId)) {
          return true; // 设备已经绑定，无需重复绑定
        }

        // 检查用户是否可以绑定更多设备
        if (!_multiDeviceBindingEnabled && users[i].boundDeviceIds.isNotEmpty) {
          // 如果不允许多设备绑定且用户已有绑定设备，则清空之前的设备
          users[i].boundDeviceIds.clear();
        }

        // 添加到设备列表中
        users[i].boundDeviceIds.add(deviceId);
        found = true;

        // 如果是当前登录用户，也更新当前用户信息
        final User? currentUser = await getCurrentUser();
        if (currentUser != null && currentUser.username == username) {
          await _saveCurrentUser(users[i]);
        }
      }
    }

    if (found) {
      // 保存更新后的用户列表
      final List<String> updatedUserJsonList = users.map((user) => jsonEncode(user.toJson())).toList();
      await prefs.setStringList(_usersKey, updatedUserJsonList);
      return true;
    }

    return false;
  }

  // 检查设备是否已被绑定
  static Future<bool> isDeviceBound(String deviceId) async {
    final List<User> users = await getUsers();

    for (var user in users) {
      // 检查设备ID列表
      if (user.boundDeviceIds.contains(deviceId)) {
        return true;
      }
    }

    return false;
  }

  // 获取绑定设备的用户
  static Future<User?> getUserByDeviceId(String deviceId) async {
    final List<User> users = await getUsers();

    for (var user in users) {
      // 检查设备ID列表
      if (user.boundDeviceIds.contains(deviceId)) {
        return user;
      }
    }

    return null;
  }

  // 解绑用户的设备
  static Future<bool> unbindDeviceFromUser(String username, String deviceId) async {
    final prefs = await _getPrefs();
    if (prefs == null) return false;

    final List<String>? userJsonList = prefs.getStringList(_usersKey);
    if (userJsonList == null || userJsonList.isEmpty) {
      return false;
    }

    List<User> users = [];
    for (var userJson in userJsonList) {
      try {
        final Map<String, dynamic> userMap = Map<String, dynamic>.from(jsonDecode(userJson));
        users.add(User.fromJson(userMap));
      } catch (e) {
        debugPrint('在unbindDeviceFromUser中解析用户JSON出错: $e');
      }
    }

    // 查找用户并移除设备ID
    bool found = false;
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == username) {
        // 从设备列表中移除
        users[i].boundDeviceIds.remove(deviceId);
        found = true;

        // 如果是当前登录用户，也更新当前用户信息
        final User? currentUser = await getCurrentUser();
        if (currentUser != null && currentUser.username == username) {
          await _saveCurrentUser(users[i]);
        }
      }
    }

    if (found) {
      // 保存更新后的用户列表
      final List<String> updatedUserJsonList = users.map((user) => jsonEncode(user.toJson())).toList();
      await prefs.setStringList(_usersKey, updatedUserJsonList);
      return true;
    }

    return false;
  }

  // 获取用户绑定的所有设备
  static Future<List<String>> getUserBoundDevices(String username) async {
    final List<User> users = await getUsers();

    for (var user in users) {
      if (user.username == username) {
        return user.boundDeviceIds;
      }
    }

    return [];
  }

  // 检查用户是否可以绑定更多设备
  static Future<bool> canUserBindMoreDevices(String username) async {
    // 如果允许多设备绑定，则始终返回true
    if (_multiDeviceBindingEnabled) {
      return true;
    }

    // 如果不允许多设备绑定，则检查用户当前是否已绑定设备
    final List<String> boundDevices = await getUserBoundDevices(username);
    return boundDevices.isEmpty;
  }
}