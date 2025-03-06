import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/widgets.dart';
import '../helpers/notification_helper.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ReminderService {
  // Start a reminder
  Future<void> startReminder() async {
    // Schedule the alarm
    if (Platform.isAndroid) {
      await AndroidAlarmManager.oneShot(
        const Duration(seconds: 1), // Adjust the duration as needed
        0, // Alarm ID
        _alarmCallback,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    }
    else if (Platform.isIOS) {
      // TODO iOS version
    }
  }

  // Alarm callback function
  static Future<void> _alarmCallback() async {
    // Initialize Flutter bindings
    WidgetsFlutterBinding.ensureInitialized();

    try {
      // Initialize the notification helper
      await NotificationHelper.initialize();

      // Show the notification
      await NotificationHelper.showNotification(
        'Time to drink water',
        'Stay hydrated by drinking water!',
      );
    } catch (e, stackTrace) {
      print('Error in _alarmCallback: $e');
      print('Stack trace: $stackTrace');
    }
  }
}
