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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "battery": MessageLookupByLibrary.simpleMessage("电量"),
    "bluetoothIsOff": MessageLookupByLibrary.simpleMessage("蓝牙已关闭或不可用"),
    "bluetoothIsOn": MessageLookupByLibrary.simpleMessage("蓝牙已开启"),
    "bluetoothScanner": MessageLookupByLibrary.simpleMessage("蓝牙扫描器"),
    "bluetooth_home_page": MessageLookupByLibrary.simpleMessage(
      "==================== 蓝牙首页 ==================== ",
    ),
    "calendar_page": MessageLookupByLibrary.simpleMessage(
      "==================== 日历页面 ==================== ",
    ),
    "connect": MessageLookupByLibrary.simpleMessage("连接"),
    "connecting": MessageLookupByLibrary.simpleMessage("正在连接..."),
    "dataPacketReceived": MessageLookupByLibrary.simpleMessage("已接收到数据包："),
    "default_page": MessageLookupByLibrary.simpleMessage(
      "==================== 默认页面 ==================== ",
    ),
    "deviceId": MessageLookupByLibrary.simpleMessage("设备ID"),
    "disconnect": MessageLookupByLibrary.simpleMessage("断开连接"),
    "disconnected": MessageLookupByLibrary.simpleMessage("已断开连接"),
    "drinkLog": MessageLookupByLibrary.simpleMessage("饮水记录"),
    "getPrefsError": m0,
    "getPrefsTimeout": MessageLookupByLibrary.simpleMessage(
      "SharedPreferences 初始化超时",
    ),
    "homeTabContent": MessageLookupByLibrary.simpleMessage("首页内容"),
    "home_page": MessageLookupByLibrary.simpleMessage(
      "==================== 首页 ==================== ",
    ),
    "language_provider": MessageLookupByLibrary.simpleMessage(
      "==================== 语言提供者 ==================== ",
    ),
    "loadLanguageMaxRetries": m1,
    "loadLanguageRetryFailed": m2,
    "loadLanguageSuccess": m3,
    "nextReminder": m4,
    "noDataAvailable": MessageLookupByLibrary.simpleMessage("没有更多的数据"),
    "notSupportThisDevice": MessageLookupByLibrary.simpleMessage("此设备不支持蓝牙"),
    "on": MessageLookupByLibrary.simpleMessage("开启"),
    "overview": MessageLookupByLibrary.simpleMessage("概览"),
    "parsedData": MessageLookupByLibrary.simpleMessage("解析数据"),
    "percentGoal": MessageLookupByLibrary.simpleMessage("目标完成百分比"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "哎呀！似乎缺少一些必要的权限。请在设置中启用它们以继续使用该应用。",
    ),
    "permissionNeeded": MessageLookupByLibrary.simpleMessage("所需权限"),
    "permission_denied_page": MessageLookupByLibrary.simpleMessage(
      "==================== 权限被拒页面 ==================== ",
    ),
    "power": MessageLookupByLibrary.simpleMessage("电源"),
    "progressGoal": MessageLookupByLibrary.simpleMessage("进度 / 目标"),
    "saveLanguageError": m5,
    "saveLanguageSuccess": m6,
    "scanForDevices": MessageLookupByLibrary.simpleMessage("扫描设备"),
    "serial": MessageLookupByLibrary.simpleMessage("序列号"),
    "stayHydrated": MessageLookupByLibrary.simpleMessage("保持水分摄入很重要！"),
    "successfulConnect": MessageLookupByLibrary.simpleMessage("连接成功"),
    "timeToDrinkWater": MessageLookupByLibrary.simpleMessage("该喝水了 • 现在"),
    "today": MessageLookupByLibrary.simpleMessage("今天"),
    "todayProgress": MessageLookupByLibrary.simpleMessage("今日进度"),
    "turnOnBluetooth": MessageLookupByLibrary.simpleMessage("请开启蓝牙"),
    "type": MessageLookupByLibrary.simpleMessage("类型"),
    "viewAll": MessageLookupByLibrary.simpleMessage("查看全部"),
  };
}
