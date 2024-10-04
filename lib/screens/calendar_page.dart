import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';

class CalendarTab extends StatefulWidget {
  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _selectedDate = DateTime.now(); // Default date is today
  List<Map<String, String>>? _currentDrinkLogs; // Drink log for selected date
  bool _hasData = true; // To determine if there's data for the selected date

  // Example data
  Map<String, List<Map<String, String>>> drinkData = {
    '2024-10-01': [
      {'time': '8:00 AM', 'volume': '200 ML'},
      {'time': '12:00 PM', 'volume': '300 ML'},
      {'time': '6:00 PM', 'volume': '100 ML'},
      {'time': '8:00 AM', 'volume': '200 ML'},
      {'time': '12:00 PM', 'volume': '300 ML'},
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

  // Increase the selected date by one day
  void _increaseDate() {
    if (_selectedDate.isBefore(DateTime.now())) {
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
      _currentDrinkLogs = drinkData[formattedDate];
      _hasData = true;
    } else {
      _currentDrinkLogs = [];
      _hasData = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Avoid content overflow when keyboard is displayed
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/water_background.png'),
                // Background image
                fit: BoxFit
                    .cover, // Make sure the background covers the entire screen
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              // Allow content scrolling
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildDateHeader(), // Date header with arrows
                    const SizedBox(height: 20),
                    _buildOverviewSection(), // Overview section
                    const SizedBox(height: 20),
                    _buildDrinkLogSection(context), // Drink Log section
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the header with the current date and navigation arrows
  Widget _buildDateHeader() {
    String formattedDate = DateFormat('EEEE, MMMM d')
        .format(_selectedDate); // Format date as "Monday, October 1"
    bool isToday = DateFormat('yyyy-MM-dd').format(_selectedDate) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the date
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: _decreaseDate, // Decrease the date
        ),
        GestureDetector(
          onTap: () => _selectDate(context), // Show date picker
          child: Row(
            children: [
              Text(
                isToday
                    ? '${S.of(context).today} (${DateFormat('yyyy-MM-dd').format(_selectedDate)})'
                    : formattedDate, // Show "Today" or the formatted date
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: _selectedDate.isBefore(DateTime.now())
              ? _increaseDate
              : null, // Increase the date if not today
        ),
      ],
    );
  }

  // Build the Overview section
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).overview,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOverviewCard(
                S.of(context).progressGoal, _hasData ? '600 / 3000 ML' : 'NIL'),
            _buildOverviewCard(
                S.of(context).percentGoal, _hasData ? '20%' : 'NIL'),
          ],
        ),
      ],
    );
  }

  // Build individual Overview cards
  Widget _buildOverviewCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 10),
            Text(value),
          ],
        ),
      ),
    );
  }

  // Build the Drink Log section
  Widget _buildDrinkLogSection(BuildContext context) {
    List<Map<String, String>> displayedLogs =
        _currentDrinkLogs!.take(5).toList(); // Show up to 5 logs

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Drink Log title and View All button
          children: [
            Text(
              S.of(context).drinkLog,
            ),
            // Only show View All if there are more than 5 logs
            _hasData && _currentDrinkLogs!.length > 5
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrinkLogPage(drinkLogs: _currentDrinkLogs!)),
                      );
                    },
                    child: Text(S.of(context).viewAll),
                  )
                : Container(),
            // Do not show View All if there are fewer than 5 logs
          ],
        ),
        const SizedBox(height: 10),
        // Show logs or "No more data" message if there are no logs
        _hasData
            ? Column(
                children: displayedLogs
                    .map((log) =>
                        _buildDrinkLogItem(log['time']!, log['volume']!))
                    .toList(),
              )
            : Center(
                child: Text(
                  S.of(context).noDataAvailable,
                ),
              ),
      ],
    );
  }

  // Build individual Drink Log items
  Widget _buildDrinkLogItem(String time, String volume) {
    return ListTile(
      title: Text(time),
      trailing: Text(volume),
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
        title: Text(S.of(context).drinkLog),
      ),
      body: ListView.builder(
        itemCount: drinkLogs.length,
        itemBuilder: (context, index) {
          final log = drinkLogs[index];
          return ListTile(
            title: Text(log['time']!),
            trailing: Text(log['volume']!),
          );
        },
      ),
    );
  }
}
