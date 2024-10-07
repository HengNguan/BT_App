import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled2/screens/home_page.dart';
import 'package:untitled2/utils/permission_utility.dart';
import 'Base/bluetooth_provider.dart';
import 'screens/bluetooth_home_page.dart';
import 'generated/l10n.dart';
import 'helpers/notification_helper.dart';

void main() async {
  // Ensure that the Flutter framework is initialized before interacting with platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NotificationHelper
  await NotificationHelper.initialize();

  // Request necessary permissions on first launch
  bool permissionsGranted = await PermissionUtility.requestPermissions();

}

class BluetoothApp extends StatelessWidget {
  const BluetoothApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Water Bottle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomeScreen(),
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
