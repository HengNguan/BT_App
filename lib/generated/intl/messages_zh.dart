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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "drinkLog": MessageLookupByLibrary.simpleMessage("饮水日志"),
        "noDataAvailable": MessageLookupByLibrary.simpleMessage("没有更多的数据"),
        "overview": MessageLookupByLibrary.simpleMessage("概览"),
        "percentGoal": MessageLookupByLibrary.simpleMessage("目标百分比"),
        "progressGoal": MessageLookupByLibrary.simpleMessage("进度 / 目标"),
        "today": MessageLookupByLibrary.simpleMessage("今天"),
        "viewAll": MessageLookupByLibrary.simpleMessage("查看全部")
      };
}
