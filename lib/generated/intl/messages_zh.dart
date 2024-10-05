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

  static String m0(countdown) => "下一个提醒在 ${countdown} 小时后";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bluetoothIsOff": MessageLookupByLibrary.simpleMessage("蓝牙已关闭或不可用"),
        "bluetoothIsOn": MessageLookupByLibrary.simpleMessage("蓝牙已开启"),
        "bluetoothScanner": MessageLookupByLibrary.simpleMessage("蓝牙扫描器"),
        "bluetooth_home_page": MessageLookupByLibrary.simpleMessage(
            "==================== 蓝牙首页 ==================== "),
        "calendar_page": MessageLookupByLibrary.simpleMessage(
            "==================== 日历页面 ==================== "),
        "connecting": MessageLookupByLibrary.simpleMessage("正在连接..."),
        "dataPacketReceived": MessageLookupByLibrary.simpleMessage("已接收到数据包："),
        "default_page": MessageLookupByLibrary.simpleMessage(
            "==================== 默认页面 ==================== "),
        "disconnected": MessageLookupByLibrary.simpleMessage("已断开连接"),
        "drinkLog": MessageLookupByLibrary.simpleMessage("饮水记录"),
        "homeTabContent": MessageLookupByLibrary.simpleMessage("首页内容"),
        "home_page": MessageLookupByLibrary.simpleMessage(
            "==================== 首页 ==================== "),
        "nextReminder": m0,
        "noDataAvailable": MessageLookupByLibrary.simpleMessage("没有更多的数据"),
        "notSupportThisDevice":
            MessageLookupByLibrary.simpleMessage("此设备不支持蓝牙"),
        "overview": MessageLookupByLibrary.simpleMessage("概览"),
        "parsedData": MessageLookupByLibrary.simpleMessage("解析数据"),
        "percentGoal": MessageLookupByLibrary.simpleMessage("目标完成百分比"),
        "permissionDenied": MessageLookupByLibrary.simpleMessage(
            "哎呀！似乎缺少一些必要的权限。请在设置中启用它们以继续使用该应用。"),
        "permissionNeeded": MessageLookupByLibrary.simpleMessage("所需权限"),
        "permission_denied_page": MessageLookupByLibrary.simpleMessage(
            "==================== 权限被拒页面 ==================== "),
        "progressGoal": MessageLookupByLibrary.simpleMessage("进度 / 目标"),
        "reminder_content": MessageLookupByLibrary.simpleMessage("保持充足的水分！"),
        "reminder_service": MessageLookupByLibrary.simpleMessage(
            "==================== 提醒服务 ==================== "),
        "reminder_title": MessageLookupByLibrary.simpleMessage("是时候喝水了"),
        "successfulConnect": MessageLookupByLibrary.simpleMessage("连接成功"),
        "today": MessageLookupByLibrary.simpleMessage("今天"),
        "todayProgress": MessageLookupByLibrary.simpleMessage("今日进度"),
        "turnOnBluetooth": MessageLookupByLibrary.simpleMessage("请开启蓝牙"),
        "viewAll": MessageLookupByLibrary.simpleMessage("查看全部")
      };
}
