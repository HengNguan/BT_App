import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled2/screens/home_page.dart';
import 'package:untitled2/utils/permission_utility.dart';
import 'Constant/ConstantStyling.dart';
import 'generated/l10n.dart';
import 'helpers/notification_helper.dart';

void main() async {
  // Ensure that the Flutter framework is initialized before interacting with platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NotificationHelper
  await NotificationHelper.initialize();

  // Request necessary permissions on first launch
  bool permissionsGranted = await PermissionUtility.requestPermissions();

  if (!permissionsGranted) {
    // Handle the case where permissions are not granted
    runApp(const PermissionDeniedApp());
  } else {
    // Initialize Android Alarm Manager
    await AndroidAlarmManager.initialize();

    // Run the main app
    runApp(const BluetoothApp());
  }
}

class BluetoothApp extends StatelessWidget {
  const BluetoothApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth App',
      //initialRoute: '/',
      //routes: {
      //  '/': (context) =>  HomeScreen(),
      //  '/default': (context) => defaultPage(),
      //  '/debug': (context) => BluetoothHomePage(),
      //},
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      //home: const BluetoothHomePage(),
    );
  }
}

class PermissionDeniedApp extends StatelessWidget {
  const PermissionDeniedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).permissionNeeded,
                      style: AppTextStyles.title18Bold,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).permissionDenied,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular16,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/default');
//               },
//               child: Text('Go to User UI'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/debug');
//               },
//               child: Text('Go to Debug UI'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
