// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(countdown) => "Next reminder in ${countdown} hours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bluetoothIsOff": MessageLookupByLibrary.simpleMessage(
            "Bluetooth is OFF or unavailable"),
        "bluetoothIsOn":
            MessageLookupByLibrary.simpleMessage("Bluetooth is ON"),
        "bluetoothScanner":
            MessageLookupByLibrary.simpleMessage("Bluetooth Scanner"),
        "bluetooth_home_page": MessageLookupByLibrary.simpleMessage(
            "==================== Bluetooth Home page ==================== "),
        "calendar_page": MessageLookupByLibrary.simpleMessage(
            "==================== Calendar page ==================== "),
        "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
        "dataPacketReceived":
            MessageLookupByLibrary.simpleMessage("Data Packets Received:"),
        "default_page": MessageLookupByLibrary.simpleMessage(
            "==================== Default page ==================== "),
        "disconnected": MessageLookupByLibrary.simpleMessage("Disconnected"),
        "drinkLog": MessageLookupByLibrary.simpleMessage("Drink Log"),
        "homeTabContent":
            MessageLookupByLibrary.simpleMessage("Home Tab Content"),
        "home_page": MessageLookupByLibrary.simpleMessage(
            "==================== Home page ==================== "),
        "nextReminder": m0,
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available"),
        "notSupportThisDevice": MessageLookupByLibrary.simpleMessage(
            "Bluetooth not supported by this device"),
        "overview": MessageLookupByLibrary.simpleMessage("Overview"),
        "parsedData": MessageLookupByLibrary.simpleMessage("Parsed Data"),
        "percentGoal":
            MessageLookupByLibrary.simpleMessage("% Of Goal Achieve"),
        "permissionDenied": MessageLookupByLibrary.simpleMessage(
            "Oops! It looks like some necessary permissions are missing. Please enable them in settings to continue using the app."),
        "permissionNeeded":
            MessageLookupByLibrary.simpleMessage("Permissions Needed"),
        "permission_denied_page": MessageLookupByLibrary.simpleMessage(
            "==================== Permission Denied page ==================== "),
        "progressGoal": MessageLookupByLibrary.simpleMessage("Progress / Goal"),
        "reminder_content": MessageLookupByLibrary.simpleMessage(
            "Stay hydrated by drinking water!"),
        "reminder_service": MessageLookupByLibrary.simpleMessage(
            "==================== Reminder Service ==================== "),
        "reminder_title":
            MessageLookupByLibrary.simpleMessage("Time to drink water"),
        "successfulConnect":
            MessageLookupByLibrary.simpleMessage("Successful Connect"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "todayProgress":
            MessageLookupByLibrary.simpleMessage("Today\'s Progress"),
        "turnOnBluetooth":
            MessageLookupByLibrary.simpleMessage("Please turn on Bluetooth"),
        "viewAll": MessageLookupByLibrary.simpleMessage("View All")
      };
}
