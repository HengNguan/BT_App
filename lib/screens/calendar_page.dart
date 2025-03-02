import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Constant/ConstantString.dart';
import '../Constant/ConstantStyling.dart';
import '../generated/l10n.dart';
import '../widgets/language_switch_button.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _selectedDate = DateTime.now(); // Default date is today
  List<Map<String, String>>? _currentDrinkLogs; // Drink log for selected date
  bool _hasData = true; // To determine if there's data for the selected date
  int _totalVolume = 0; // To keep track of total volume consumed for the day

  // Example data
  Map<String, List<Map<String, String>>> drinkData = {
    '2024-10-01': [
      {'time': '8:00 AM', 'volume': '200 ML'},
      {'time': '12:00 PM', 'volume': '300 ML'},
      {'time': '9:00 PM', 'volume': '300 ML'},
      {'time': '11:00 PM', 'volume': '100 ML'},
      {'time': '6:00 PM', 'volume': '100 ML'},
      {'time': '6:00 PM', 'volume': '100 ML'},
    ],
    '2024-09-30': [
      {'time': '9:00 AM', 'volume': '100 ML'},
      {'time': '3:00 PM', 'volume': '150 ML'},
    ]
  };

  @override
  void initState() {
    super.initState();
    _updateDrinkLogs(); // Initialize drink log for today
  }

  // Decrease the selected date by one day
  void _decreaseDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
      _updateDrinkLogs(); // Update the drink log for the selected date
    });
  }

  // Increase the selected date by one day, but not beyond today
  void _increaseDate() {
    // Compare only the date part (year, month, day)
    if (DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
        .isBefore(DateTime.now())) {
      setState(() {
        _selectedDate = _selectedDate.add(Duration(days: 1));
        _updateDrinkLogs(); // Update the drink log for the selected date
      });
    }
  }

  // Select date using a date picker
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Disallow future dates
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF2E7CFF),
              onPrimary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF2E7CFF),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateDrinkLogs(); // Update drink logs after changing the date
      });
    }
  }

  // Update the drink log for the currently selected date
  void _updateDrinkLogs() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    if (drinkData.containsKey(formattedDate)) {
      _currentDrinkLogs = List.from(drinkData[formattedDate]!); // Copy the data
      _hasData = true;
      _sortDrinkLogsByTime(); // Sort drink logs by time
      _calculateTotalVolume(); // Calculate total volume for the day
    } else {
      _currentDrinkLogs = [];
      _hasData = false;
      _totalVolume = 0; // Reset total volume if no data
    }
  }

  // Sort the drink logs by time
  void _sortDrinkLogsByTime() {
    DateFormat timeFormat =
    DateFormat('h:mm a'); // Parse time in "8:00 AM" format
    _currentDrinkLogs!.sort((a, b) {
      DateTime timeA = timeFormat.parse(a['time']!);
      DateTime timeB = timeFormat.parse(b['time']!);
      return timeA.compareTo(timeB); // Compare two DateTime objects
    });
  }

  // Calculate the total volume from the drink log
  void _calculateTotalVolume() {
    _totalVolume = 0; // Reset total volume
    for (var log in _currentDrinkLogs!) {
      String volumeString = log['volume']!;
      int volume =
      int.parse(volumeString.split(' ')[0]); // Extract number from "200 ML"
      _totalVolume += volume;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕高度，以便计算需要填充的空间
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = 0; // 没有AppBar
    final bottomNavBarHeight = 56.0; // 底部导航栏的高度
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF2F7FF),
              Color(0xFFE6F0FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 主内容可滚动区域
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // 确保最小高度填充整个可见区域
                  constraints: BoxConstraints(
                    minHeight: screenHeight - statusBarHeight - bottomNavBarHeight - 30, // 减去一些边距
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 40), // 增加空间，确保不会与语言切换按钮重叠
                        _buildDateHeader(), // Date header with arrows
                        SizedBox(height: 24),
                        _buildWaterCircle(), // Water tracking circle
                        SizedBox(height: 24),
                        _buildOverviewSection(), // Overview section
                        SizedBox(height: 24),
                        _buildDrinkLogSection(context), // Drink Log section
                        SizedBox(height: 50), // 底部额外空间填充
                      ],
                    ),
                  ),
                ),
              ),
              // Language switcher positioned at top-right
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: LanguageSwitchButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the header with the current date and navigation arrows
  Widget _buildDateHeader() {
    String formattedDate = DateFormat('EEEE, MMMM d').format(_selectedDate);
    bool isToday = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
        .isAtSameMomentAs(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildDateNavButton(Icons.arrow_back_ios, _decreaseDate),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Color(0xFF2E7CFF),
                ),
                SizedBox(width: 8),
                Text(
                  isToday
                      ? '${S.of(context).today}'
                      : formattedDate,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          _buildDateNavButton(
            Icons.arrow_forward_ios,
            DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
                .isBefore(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day))
                ? _increaseDate
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDateNavButton(IconData icon, Function()? onPressed) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: onPressed == null ? Colors.grey.withOpacity(0.1) : Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 16,
          color: onPressed == null ? Colors.grey : Color(0xFF2E7CFF),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  // Build Water Circle Widget
  Widget _buildWaterCircle() {
    double percentage = _hasData ? (_totalVolume / 3000).clamp(0.0, 1.0) : 0.0;

    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF2E7CFF).withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF2E7CFF).withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Water
            ClipOval(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: percentage,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7CFF).withOpacity(0.3),
                  ),
                ),
              ),
            ),
            // Simple Wave
            ClipOval(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: percentage,
                child: Container(
                  width: 190,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF2E7CFF).withOpacity(0.2),
                        Color(0xFF2E7CFF).withOpacity(0.3),
                        Color(0xFF2E7CFF).withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_hasData ? "$_totalVolume" : "0"}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7CFF),
                    ),
                  ),
                  Text(
                    'ML',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2E7CFF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the Overview section
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).overview,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7CFF),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                title: S.of(context).progressGoal,
                value: _hasData ? '$_totalVolume / 3000 ML' : 'NIL',
                icon: Icons.bar_chart,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildOverviewCard(
                title: S.of(context).percentGoal,
                value: _hasData
                    ? '${(_totalVolume / 3000 * 100).toStringAsFixed(1)}%'
                    : 'NIL',
                icon: Icons.pie_chart,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build individual Overview cards
  Widget _buildOverviewCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF2E7CFF),
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build the Drink Log section
  Widget _buildDrinkLogSection(BuildContext context) {
    List<Map<String, String>> displayedLogs =
        _currentDrinkLogs?.take(5).toList() ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).drinkLog,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7CFF),
              ),
            ),
            if (_hasData && (_currentDrinkLogs?.length ?? 0) > 5)
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DrinkLogPage(drinkLogs: _currentDrinkLogs!),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF2E7CFF),
                ),
                child: Text(
                  S.of(context).viewAll,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: _hasData && displayedLogs.isNotEmpty
              ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: displayedLogs.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            itemBuilder: (context, index) {
              final log = displayedLogs[index];
              return _buildDrinkLogItem(log['time']!, log['volume']!);
            },
          )
              : Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                S.of(context).noDataAvailable,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build individual Drink Log items
  Widget _buildDrinkLogItem(String time, String volume) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.water_drop,
              color: Color(0xFF2E7CFF),
              size: 18,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              time,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              volume,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7CFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Drink Log page showing all logs
class DrinkLogPage extends StatelessWidget {
  final List<Map<String, String>> drinkLogs;

  DrinkLogPage({required this.drinkLogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).drinkLog,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF2E7CFF),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF2F7FF),
              Color(0xFFE6F0FF),
            ],
          ),
        ),
        child: ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: drinkLogs.length,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final log = drinkLogs[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6F0FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.water_drop,
                        color: Color(0xFF2E7CFF),
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        log['time']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6F0FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        log['volume']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7CFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}