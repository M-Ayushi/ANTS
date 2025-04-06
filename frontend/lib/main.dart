import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime today = DateTime.now();

  // Store custom colors for specific days in a map
  // Key is the DateTime, and Value is the Color
  final Map<DateTime, Map<String, dynamic>> dayData = {
    DateTime(2025, 4, 6): {
      'color': Colors.green,
      'event': 'Special event on this day!',
    },
    DateTime(2025, 4, 10): {
      'color': Colors.red,
      'event': 'Birthday Party!',
    },
  };

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Panic Zone")), body: content());
  }

  Widget content() {
    return Column(
      children: [
        Text("Selected Day: " + today.toString().split(" ")[0]),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today, // current date
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,

              // 🎨 Customizing the selected day
              calendarStyle: CalendarStyle(

                // Customize the appearance of every day
                defaultDecoration: BoxDecoration(
                  color: _getDayColor(today),
                  shape: BoxShape.circle, // Circle shape for each day
                ),
                defaultTextStyle: TextStyle(
                  color: Colors.black, // Text color for all days
                  fontSize: 16, // Font size for all days
                ),

                // Customize the appearance of the selected day
                selectedDecoration: BoxDecoration(
                  color: Colors.purple, // Background color for selected day
                  shape: BoxShape.circle, // Round shape
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white, // Text color for selected day
                  fontWeight: FontWeight.bold,
                ),

                // Optionally, change the background of today's date (if needed)
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent, // Background for today's date
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.white, // Text color for today's date
                ),
              ),

              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.sunday) {
                    final text = DateFormat.E().format(day);

                    return Center(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function to determine the background color based on multiple conditions
  // Fetching color and event from the map
  Color _getDayColor(DateTime day) {
    var dayInfo = dayData[DateTime(day.year, day.month, day.day)];
    return dayInfo?['color'] ?? Colors.white;
  }

  String _getDayEvent(DateTime day) {
    var dayInfo = dayData[DateTime(day.year, day.month, day.day)];
    return dayInfo?['event'] ?? '';
  }

}
