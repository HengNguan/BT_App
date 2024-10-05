import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtility {
  // Request all necessary permissions
  static Future<bool> requestPermissions() async {
    // List of permissions to request
    List<Permission> permissions = [];

    if (Platform.isAndroid) {
      permissions.addAll([
        Permission.notification,
        // Add other permissions as needed
      ]);
    } else if (Platform.isIOS) {
      permissions.addAll([
        Permission.notification,
        // Add other permissions as needed
      ]);
    }

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    // Check if all permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    return allGranted;
  }
}
