import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/widgets.dart';
import '../helpers/notification_helper.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

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
      // Schedule local notification for iOS
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
          FlutterLocalNotificationsPlugin();
          
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // notification id
        'Time to drink water',
        'Stay hydrated by drinking water!',
        tz.TZDateTime.from(DateTime.now().add(const Duration(seconds: 1)), tz.local),
        const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: 
            UILocalNotificationDateInterpretation.absoluteTime,
      );
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
