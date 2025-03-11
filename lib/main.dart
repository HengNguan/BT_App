import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled2/screens/home_page.dart';
import 'package:untitled2/utils/permission_utility.dart';
import 'Base/bluetooth_provider.dart';
import 'Constant/ConstantStyling.dart';
import 'screens/bluetooth_home_page.dart';
import 'screens/login_page.dart';
import 'generated/l10n.dart';
import 'helpers/notification_helper.dart';

import 'providers/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/auth_service.dart';

import 'package:timezone/data/latest.dart' as tz;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  // 确保Flutter框架在与平台通道交互之前已初始化
  WidgetsFlutterBinding.ensureInitialized();


  // 预热 SharedPreferences
  try {
    await SharedPreferences.getInstance();
    debugPrint('SharedPreferences 预热成功');
  } catch (e) {
    debugPrint('SharedPreferences 预热失败: $e');
    // 继续执行，LanguageProvider 将处理重试
  }

  // Initialize timezone data
  tz.initializeTimeZones();


  // Initialize NotificationHelper
  await NotificationHelper.initialize();

  // Request necessary permissions on first launch\
  //bool permissionsGranted = await PermissionUtility.requestPermissions();
  bool permissionsGranted = true;

  if (!permissionsGranted) {
    // Handle the case where permissions are not granted
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ],
        child: const PermissionDeniedApp(),
      ),
    );
  } else {
    // Initialize Android Alarm Manager
    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
    }
    else if (Platform.isIOS) {
    // TODO iOS version
    }
    // Run the main app
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BluetoothProvider()),
          ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ],
        child: const BluetoothApp(),
      ),
    );
  }
}

class BluetoothApp extends StatelessWidget {
  const BluetoothApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'Bluetooth Water Bottle',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: languageProvider.locale,
          home: FutureBuilder<User?>(
            future: AuthService.getCurrentUser(),
            builder: (context, snapshot) {
              // 处理加载状态
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                // 处理错误状态
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          '发生错误',
                          style: AppTextStyles.title18Bold,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${snapshot.error}',
                          style: AppTextStyles.regular16,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // 尝试导航到登录页面
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => LoginPage(checkCurrentUser: false)),
                            );
                          },
                          child: Text('重试'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // 处理成功状态
                final User? currentUser = snapshot.data;

                // 如果有用户，导航到主页；否则导航到登录页面
                return currentUser != null
                    ? HomeScreen()
                    : LoginPage(
                  onLoginSuccess: () {
                    // 登录成功后导航到主页
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}

class PermissionDeniedApp extends StatelessWidget {
  const PermissionDeniedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: languageProvider.locale,
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
      },
    );
  }
}


