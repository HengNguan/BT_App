import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Constant/ConstantString.dart';
import '../Constant/ConstantStyling.dart';
import '../generated/l10n.dart';

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
    super.build(context); // Ensure that super.build is called
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
        .format(_selectedDate); // "Monday, October 1"

    // Compare only the date part (year, month, day) to check if it's today
    bool isToday =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
            .isAtSameMomentAs(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: _decreaseDate,
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Row(
            children: [
              Text(
                isToday
                    ? '${S.of(context).today} (${DateFormat('yyyy-MM-dd').format(_selectedDate)})'
                    : formattedDate,
                style: AppTextStyles.bold12,
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: DateTime(_selectedDate.year, _selectedDate.month,
                      _selectedDate.day)
                  .isBefore(DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day))
              ? _increaseDate
              : null,
        ),
      ],
    );
  }

  // Build the Overview section
  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).overview, style: AppTextStyles.title18Bold),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOverviewCard(S.of(context).progressGoal,
                _hasData ? '$_totalVolume / 3000 ML' : 'NIL'),
            // Display total volume dynamically
            _buildOverviewCard(
                S.of(context).percentGoal,
                _hasData
                    ? '${(_totalVolume / 3000 * 100).toStringAsFixed(1)}%'
                    : 'NIL'),
            // Calculate percentage based on total volume
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
            Text(title, style: AppTextStyles.grey12Regular),
            const SizedBox(height: 10),
            Text(value, style: AppTextStyles.regular12),
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
            Text(S.of(context).drinkLog, style: AppTextStyles.title18Bold),
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
                    child: Text(S.of(context).viewAll,
                        style: AppTextStyles.regular12),
                  )
                : Container(),
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
                child: Text(S.of(context).noDataAvailable,
                    style: AppTextStyles.regular12),
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
