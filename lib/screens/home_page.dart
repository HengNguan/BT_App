import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/ConstantString.dart';
import '../Constant/ConstantStyling.dart';
import '../generated/l10n.dart';
import '../services/reminder_service.dart';
import 'bluetooth_home_page.dart';
import 'calendar_page.dart';
import 'default_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final ReminderService _reminderService;

  static final List<Widget> _widgetOptions = <Widget>[
    //HomeTab(),
    //const DefaultPage(),
    BluetoothHomePage(),
    CalendarTab(),
  ];

  @override
  void initState() {
    super.initState();

    _reminderService = ReminderService();
    _reminderService.startReminder();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bluetooth App'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // Ensure labels are always shown
        items: const <BottomNavigationBarItem>[
         // BottomNavigationBarItem(
         //   icon: Icon(Icons.error_outline),
         //   label: 'Placeholder',
         // ),
         // BottomNavigationBarItem(
         //   icon: Icon(Icons.person),
         //   label: 'User UI',
         // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).homeTabContent, style: AppTextStyles.title18Bold)
    );
  }
}
