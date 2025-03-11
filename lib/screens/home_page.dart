import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../services/auth_service.dart';
import 'bluetooth_home_page.dart';
import 'calendar_page.dart';

import 'login_page.dart';
import 'profile_page.dart';

import 'default_page.dart';
import '../helpers/notification_helper.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  User? _currentUser;
  bool _isLoading = true;

  // 不使用late final，改为普通变量
  List<Widget>? _widgetOptions;

  @override
  void initState() {
    super.initState();

    // 初始化用户数据
    _initializeUsers();
    // 检查当前登录用户
    _checkCurrentUser();
  }

  // 构建页面列表，确保ProfilePage接收最新的onLogout回调
  List<Widget> _buildWidgetOptions() {
    return <Widget>[
      BluetoothHomePage(),
      CalendarTab(),
      ProfilePage(
        onLogout: _handleLogout,
      ),
    ];
  }

  Future<void> _initializeUsers() async {
    await AuthService.initializeUsers();
  }

  Future<void> _checkCurrentUser() async {
    setState(() {
      _isLoading = true;
    });

    final user = await AuthService.getCurrentUser();

    if (mounted) {
      setState(() {
        _currentUser = user;
        _isLoading = false;

        // 如果没有登录用户，跳转到登录页面
        if (user == null) {
          _navigateToLogin();
        }
      });
    }
  }

  // 统一的注销处理逻辑
  Future<void> _handleLogout() async {
    await AuthService.logout();

    if (mounted) {
      // 确保清空当前用户状态
      setState(() {
        _currentUser = null;
      });

      // 导航到登录页面并清除堆栈
      _navigateToLogin();
    }
  }

  // 导航到登录页面的统一方法
  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginPage(
          checkCurrentUser: false, // 防止自动登录
          onLoginSuccess: () {
            // 登录成功回调 - 返回主页
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
          (route) => false, // 清除导航堆栈
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 如果还没有初始化，则初始化widget选项列表
    final widgetOptions = _buildWidgetOptions();

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 如果没有登录用户，则不渲染主页内容
    if (_currentUser == null) {
      return Container(); // 将由initState中的导航替换
    }

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await NotificationHelper.showNotification(
            'Test Notification',
            'If you see this, notifications are working on iOS!'
          );
        },
        child: const Icon(Icons.notification_add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: S.of(context).calendar,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: S.of(context).profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF2E7CFF),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}