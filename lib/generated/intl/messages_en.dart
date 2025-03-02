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

  static String m0(error) => "Failed to get SharedPreferences: ${error}";

  static String m1(maxRetries) =>
      "Unable to load language settings after ${maxRetries} attempts, using default language";

  static String m2(attempt, error) =>
      "Language setting load attempt ${attempt} failed: ${error}";

  static String m3(languageCode) =>
      "Successfully loaded language setting: ${languageCode}";

  static String m4(countdown) => "Next reminder in ${countdown} hours";

  static String m5(error) => "Failed to save language setting: ${error}";

  static String m6(languageCode) => "Language setting saved: ${languageCode}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "availableDevices": MessageLookupByLibrary.simpleMessage("Available"),
    "battery": MessageLookupByLibrary.simpleMessage("Battery"),
    "bluetoothIsOff": MessageLookupByLibrary.simpleMessage(
      "Bluetooth is OFF or unavailable",
    ),
    "bluetoothIsOn": MessageLookupByLibrary.simpleMessage("Bluetooth is ON"),
    "bluetoothScanner": MessageLookupByLibrary.simpleMessage(
      "Bluetooth Scanner",
    ),
    "bluetooth_home_page": MessageLookupByLibrary.simpleMessage(
      "==================== Bluetooth Home page ==================== ",
    ),
    "calendar_page": MessageLookupByLibrary.simpleMessage(
      "==================== Calendar page ==================== ",
    ),
    "calibration": MessageLookupByLibrary.simpleMessage("Calibration"),
    "calibrationDeleted": MessageLookupByLibrary.simpleMessage(
      "Calibration deleted",
    ),
    "calibrationHistory": MessageLookupByLibrary.simpleMessage(
      "Calibration History",
    ),
    "calibrationSaved": MessageLookupByLibrary.simpleMessage(
      "Calibration saved successfully",
    ),
    "calibrationValueHint": MessageLookupByLibrary.simpleMessage(
      "Enter weight value",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm Delete"),
    "confirmDeleteCalibration": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this calibration record?",
    ),
    "connect": MessageLookupByLibrary.simpleMessage("Connect"),
    "connectedDevice": MessageLookupByLibrary.simpleMessage("Connected Device"),
    "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
    "dataPacketReceived": MessageLookupByLibrary.simpleMessage(
      "Data Packets Received:",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "default_page": MessageLookupByLibrary.simpleMessage(
      "==================== Default page ==================== ",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deviceId": MessageLookupByLibrary.simpleMessage("ID"),
    "deviceInfo": MessageLookupByLibrary.simpleMessage("Device Info"),
    "disconnect": MessageLookupByLibrary.simpleMessage("Disconnect"),
    "disconnected": MessageLookupByLibrary.simpleMessage("Disconnected"),
    "drinkLog": MessageLookupByLibrary.simpleMessage("Drink Log"),
    "enterCalibrationValue": MessageLookupByLibrary.simpleMessage(
      "Enter calibration value (in grams):",
    ),
    "getPrefsError": m0,
    "getPrefsTimeout": MessageLookupByLibrary.simpleMessage(
      "SharedPreferences initialization timeout",
    ),
    "homeTabContent": MessageLookupByLibrary.simpleMessage("Home Tab Content"),
    "home_page": MessageLookupByLibrary.simpleMessage(
      "==================== Home page ==================== ",
    ),
    "language_provider": MessageLookupByLibrary.simpleMessage(
      "==================== Language Provider ==================== ",
    ),
    "loadLanguageMaxRetries": m1,
    "loadLanguageRetryFailed": m2,
    "loadLanguageSuccess": m3,
    "nextReminder": m4,
    "noCalibrationHistory": MessageLookupByLibrary.simpleMessage(
      "No calibration history found",
    ),
    "noDataAvailable": MessageLookupByLibrary.simpleMessage(
      "No data available",
    ),
    "notSupportThisDevice": MessageLookupByLibrary.simpleMessage(
      "Bluetooth not supported by this device",
    ),
    "on": MessageLookupByLibrary.simpleMessage("On"),
    "overview": MessageLookupByLibrary.simpleMessage("Overview"),
    "percentGoal": MessageLookupByLibrary.simpleMessage("% Of Goal Achieve"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Oops! It looks like some necessary permissions are missing. Please enable them in settings to continue using the app.",
    ),
    "permissionNeeded": MessageLookupByLibrary.simpleMessage(
      "Permissions Needed",
    ),
    "permission_denied_page": MessageLookupByLibrary.simpleMessage(
      "==================== Permission Denied page ==================== ",
    ),
    "power": MessageLookupByLibrary.simpleMessage("Power"),
    "progressGoal": MessageLookupByLibrary.simpleMessage("Progress / Goal"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveLanguageError": m5,
    "saveLanguageSuccess": m6,
    "scanForDevices": MessageLookupByLibrary.simpleMessage("Scan for Devices"),
    "scanning": MessageLookupByLibrary.simpleMessage("Scanning..."),
    "serial": MessageLookupByLibrary.simpleMessage("Serial"),
    "stayHydrated": MessageLookupByLibrary.simpleMessage(
      "Stay hydrated by drinking water!",
    ),
    "successfulConnect": MessageLookupByLibrary.simpleMessage(
      "Successfully Connected",
    ),
    "timeToDrinkWater": MessageLookupByLibrary.simpleMessage(
      "Time to drink water • now",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "todayProgress": MessageLookupByLibrary.simpleMessage("Today\'s Progress"),
    "turnOnBluetooth": MessageLookupByLibrary.simpleMessage(
      "Please turn on Bluetooth",
    ),
    "type": MessageLookupByLibrary.simpleMessage("Type"),
    "unknownDevice": MessageLookupByLibrary.simpleMessage("Unknown Device"),
    "useCurrentValue": MessageLookupByLibrary.simpleMessage(
      "Use Current Value",
    ),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
  };
}
