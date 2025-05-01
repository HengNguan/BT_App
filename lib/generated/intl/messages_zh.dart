// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(error) => "获取 SharedPreferences 失败：${error}";

  static String m1(maxRetries) => "在 ${maxRetries} 次尝试后无法加载语言设置，使用默认语言";

  static String m2(attempt, error) => "语言设置加载尝试 ${attempt} 失败：${error}";

  static String m3(languageCode) => "成功加载语言设置：${languageCode}";

  static String m4(countdown) => "下一个提醒在 ${countdown} 小时后";

  static String m5(error) => "保存语言设置失败：${error}";

  static String m6(languageCode) => "语言设置已保存：${languageCode}";

  static String m7(deviceName) => "欢迎使用 ${deviceName}";

  static String m8(displayName) => "欢迎，${displayName}！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "availableDevices": MessageLookupByLibrary.simpleMessage("可用设备"),
        "battery": MessageLookupByLibrary.simpleMessage("电量"),
        "bindDevice": MessageLookupByLibrary.simpleMessage("绑定设备"),
        "bindDeviceFailed": MessageLookupByLibrary.simpleMessage("绑定设备到您的账户失败"),
        "bindDeviceSuccess":
            MessageLookupByLibrary.simpleMessage("设备已成功绑定到您的账户"),
        "bluetoothIsOff": MessageLookupByLibrary.simpleMessage("蓝牙已关闭或不可用"),
        "bluetoothIsOn": MessageLookupByLibrary.simpleMessage("蓝牙已开启"),
        "bluetoothScanner": MessageLookupByLibrary.simpleMessage("蓝牙扫描器"),
        "bluetooth_home_page": MessageLookupByLibrary.simpleMessage(
            "==================== 蓝牙首页 ==================== "),
        "calendar": MessageLookupByLibrary.simpleMessage("历史"),
        "calendar_page": MessageLookupByLibrary.simpleMessage(
            "==================== 日历页面 ==================== "),
        "calibrateAfterDataReceived":
            MessageLookupByLibrary.simpleMessage("收到数据后，请进行去皮校准"),
        "calibrateLater": MessageLookupByLibrary.simpleMessage("稍后校准"),
        "calibrateNow": MessageLookupByLibrary.simpleMessage("立即校准"),
        "calibration": MessageLookupByLibrary.simpleMessage("校准"),
        "calibrationDeleted": MessageLookupByLibrary.simpleMessage("校准已删除"),
        "calibrationHistory": MessageLookupByLibrary.simpleMessage("校准历史"),
        "calibrationImportanceNote":
            MessageLookupByLibrary.simpleMessage("注意：去皮校准是确保重量数据准确性的重要步骤。"),
        "calibrationSaved": MessageLookupByLibrary.simpleMessage("校准已成功保存"),
        "calibrationTip": MessageLookupByLibrary.simpleMessage(
            "提示：校准后，系统将自动从测量值中减去此校准值，得到准确的净重。"),
        "calibrationValueHint": MessageLookupByLibrary.simpleMessage("输入重量值"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "confirm": MessageLookupByLibrary.simpleMessage("确认"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage("确认删除"),
        "confirmDeleteCalibration":
            MessageLookupByLibrary.simpleMessage("您确定要删除此校准记录吗？"),
        "confirmDeleteCalibrationData":
            MessageLookupByLibrary.simpleMessage("您是否同时要删除此设备的校准数据？"),
        "confirmUnbindDevice":
            MessageLookupByLibrary.simpleMessage("您确定要解绑此设备吗？"),
        "connect": MessageLookupByLibrary.simpleMessage("连接"),
        "connectedDevice": MessageLookupByLibrary.simpleMessage("已连接设备"),
        "connecting": MessageLookupByLibrary.simpleMessage("正在连接..."),
        "dataPacketReceived": MessageLookupByLibrary.simpleMessage("已接收到数据包："),
        "date": MessageLookupByLibrary.simpleMessage("日期"),
        "default_page": MessageLookupByLibrary.simpleMessage(
            "==================== 默认页面 ==================== "),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deviceAlreadyBound":
            MessageLookupByLibrary.simpleMessage("此设备已被其他用户绑定"),
        "deviceBound": MessageLookupByLibrary.simpleMessage("设备已绑定到您的账户"),
        "deviceGuide": MessageLookupByLibrary.simpleMessage("设备使用指南"),
        "deviceId": MessageLookupByLibrary.simpleMessage("设备ID"),
        "deviceInfo": MessageLookupByLibrary.simpleMessage("设备信息"),
        "deviceNotBound": MessageLookupByLibrary.simpleMessage("您的账户未绑定任何设备"),
        "disconnect": MessageLookupByLibrary.simpleMessage("断开连接"),
        "disconnected": MessageLookupByLibrary.simpleMessage("已断开连接"),
        "doCalibration": MessageLookupByLibrary.simpleMessage("是否校准设备?"),
        "drinkLog": MessageLookupByLibrary.simpleMessage("饮水记录"),
        "enterCalibrationValue":
            MessageLookupByLibrary.simpleMessage("使用此值校准设备："),
        "firstTimeConnectionInstructions":
            MessageLookupByLibrary.simpleMessage("这是您首次连接此设备，请按照以下步骤进行操作："),
        "getPrefsError": m0,
        "getPrefsTimeout":
            MessageLookupByLibrary.simpleMessage("SharedPreferences 初始化超时"),
        "guide_dialog": MessageLookupByLibrary.simpleMessage(
            "==================== 引导对话框 ==================== "),
        "home": MessageLookupByLibrary.simpleMessage("主页"),
        "homeTabContent": MessageLookupByLibrary.simpleMessage("首页内容"),
        "home_page": MessageLookupByLibrary.simpleMessage(
            "==================== 首页 ==================== "),
        "language_provider": MessageLookupByLibrary.simpleMessage(
            "==================== 语言提供者 ==================== "),
        "loadLanguageMaxRetries": m1,
        "loadLanguageRetryFailed": m2,
        "loadLanguageSuccess": m3,
        "login": MessageLookupByLibrary.simpleMessage("登录"),
        "loginButton": MessageLookupByLibrary.simpleMessage("登录"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("登录失败。请检查您的用户名和密码。"),
        "login_page": MessageLookupByLibrary.simpleMessage(
            "==================== 登录页面 ==================== "),
        "logout": MessageLookupByLibrary.simpleMessage("退出登录"),
        "multiDeviceBindingSubtitle":
            MessageLookupByLibrary.simpleMessage("开启后一个账号可以绑定多个设备"),
        "multiDeviceBindingTitle":
            MessageLookupByLibrary.simpleMessage("允许多设备绑定"),
        "multiDeviceCalibrationSubtitle":
            MessageLookupByLibrary.simpleMessage("开启后一个账号可以校准多个设备"),
        "multiDeviceCalibrationTitle":
            MessageLookupByLibrary.simpleMessage("允许多设备校准"),
        "nextReminder": m4,
        "no": MessageLookupByLibrary.simpleMessage("取消"),
        "noCalibrationHistory": MessageLookupByLibrary.simpleMessage("未找到校准历史"),
        "noDataAvailable": MessageLookupByLibrary.simpleMessage("没有更多的数据"),
        "notLoggedIn": MessageLookupByLibrary.simpleMessage("未登录"),
        "notSupportThisDevice":
            MessageLookupByLibrary.simpleMessage("此设备不支持蓝牙"),
        "on": MessageLookupByLibrary.simpleMessage("开启"),
        "overview": MessageLookupByLibrary.simpleMessage("概览"),
        "password": MessageLookupByLibrary.simpleMessage("密码"),
        "percentGoal": MessageLookupByLibrary.simpleMessage("目标完成百分比"),
        "permissionDenied": MessageLookupByLibrary.simpleMessage(
            "哎呀！似乎缺少一些必要的权限。请在设置中启用它们以继续使用该应用。"),
        "permissionNeeded": MessageLookupByLibrary.simpleMessage("所需权限"),
        "permission_denied_page": MessageLookupByLibrary.simpleMessage(
            "==================== 权限被拒页面 ==================== "),
        "power": MessageLookupByLibrary.simpleMessage("电源"),
        "profile": MessageLookupByLibrary.simpleMessage("我"),
        "progressGoal": MessageLookupByLibrary.simpleMessage("进度 / 目标"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "saveLanguageError": m5,
        "saveLanguageSuccess": m6,
        "scanForDevices": MessageLookupByLibrary.simpleMessage("扫描设备"),
        "scanning": MessageLookupByLibrary.simpleMessage("扫描中..."),
        "serial": MessageLookupByLibrary.simpleMessage("序列号"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "settingsUpdated": MessageLookupByLibrary.simpleMessage("设置已成功更新"),
        "stayHydrated": MessageLookupByLibrary.simpleMessage("保持水分补充！"),
        "successfulConnect": MessageLookupByLibrary.simpleMessage("连接成功"),
        "timeToDrinkWater": MessageLookupByLibrary.simpleMessage("该喝水了"),
        "today": MessageLookupByLibrary.simpleMessage("今天"),
        "todayProgress": MessageLookupByLibrary.simpleMessage("今日进度"),
        "turnOnBluetooth": MessageLookupByLibrary.simpleMessage("请开启蓝牙"),
        "type": MessageLookupByLibrary.simpleMessage("类型"),
        "unbindDevice": MessageLookupByLibrary.simpleMessage("解绑设备"),
        "unbindDeviceFailed":
            MessageLookupByLibrary.simpleMessage("从您的账户解绑设备失败"),
        "unbindDeviceSuccess":
            MessageLookupByLibrary.simpleMessage("设备已成功从您的账户解绑"),
        "unit": MessageLookupByLibrary.simpleMessage("毫升"),
        "unknownDevice": MessageLookupByLibrary.simpleMessage("未知设备"),
        "useCurrentValue": MessageLookupByLibrary.simpleMessage("使用当前值"),
        "username": MessageLookupByLibrary.simpleMessage("用户名"),
        "value": MessageLookupByLibrary.simpleMessage("值"),
        "viewAll": MessageLookupByLibrary.simpleMessage("查看全部"),
        "waitForFirstDataPacket":
            MessageLookupByLibrary.simpleMessage("请等待设备发送第一个数据包"),
        "weightDataMoreAccurate":
            MessageLookupByLibrary.simpleMessage("校准后，重量数据将更加准确"),
        "welcomeToDevice": m7,
        "welcomeUser": m8,
        "yes": MessageLookupByLibrary.simpleMessage("确定")
      };
}
