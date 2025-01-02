import 'package:flutter/material.dart';
import 'account_view.dart';
import 'calendar_view.dart';
import '../createScreen/create_view.dart';

class CalendarAccount extends StatefulWidget {
  const CalendarAccount({super.key});

  @override
  State<CalendarAccount> createState() => _CalendarAccount();
}

class _CalendarAccount extends State<CalendarAccount> {
  DateTime _selectedDay = DateTime.now();

  void _dateSelect(DateTime date) {
    setState(() {
      _selectedDay = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CalendarView(dateSelect: _dateSelect),
            Expanded(flex: 1, child: Account()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateScreen(onDate: _selectedDay)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
