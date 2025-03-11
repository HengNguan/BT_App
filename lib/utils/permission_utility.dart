import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class PermissionUtility {
  // Request all necessary permissions
  static Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      // Handle Bluetooth permission
      var bluetoothStatus = await Permission.bluetooth.status;
      if (bluetoothStatus.isPermanentlyDenied) {
        // Show dialog to direct user to settings
        bool openSettings = await showOpenSettingsDialog();
        if (openSettings) {
          await openAppSettings();
        }
        return false;
      } else if (bluetoothStatus.isDenied) {
        bluetoothStatus = await Permission.bluetooth.request();
      }
      
      // Handle Notification permission
      var notificationStatus = await Permission.notification.status;
      if (notificationStatus.isPermanentlyDenied) {
        // Show dialog to direct user to settings
        bool openSettings = await showOpenSettingsDialog();
        if (openSettings) {
          await openAppSettings();
        }
        return false;
      } else if (notificationStatus.isDenied) {
        notificationStatus = await Permission.notification.request();
      }
      
      print('After request - Bluetooth Status: $bluetoothStatus');
      print('After request - Notification Status: $notificationStatus');

      // Check both permissions
      bool isBluetoothOk = bluetoothStatus.isGranted || 
                           bluetoothStatus.isLimited || 
                           bluetoothStatus.isProvisional;
      bool isNotificationOk = notificationStatus.isGranted || 
                             notificationStatus.isLimited || 
                             notificationStatus.isProvisional;

      print('Bluetooth OK: $isBluetoothOk');
      print('Notification OK: $isNotificationOk');

      return isBluetoothOk && isNotificationOk;
    }

    // For Android
    List<Permission> permissions = [Permission.notification];
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    
    return statuses.values.every((status) => 
      status.isGranted || status.isLimited || status.isProvisional
    );
  }

  // Helper method to show settings dialog
  static Future<bool> showOpenSettingsDialog() async {
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return false;

    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permissions Required'),
        content: const Text(
          'This app needs Bluetooth and Notification permissions to function properly. '
          'Please enable them in Settings.'
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    ) ?? false;
  }
}
