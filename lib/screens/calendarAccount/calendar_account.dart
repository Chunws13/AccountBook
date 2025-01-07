import 'package:flutter/material.dart';
import 'account_view.dart';
import 'calendar_view.dart';
import '../createScreen/create_view.dart';
import '../../crud.dart';

class CalendarAccount extends StatefulWidget {
  const CalendarAccount({super.key});

  @override
  State<CalendarAccount> createState() => _CalendarAccount();
}

class _CalendarAccount extends State<CalendarAccount> {
  final repository = HistoryRepo();
  List<History> dayHistory = [];
  DateTime _selectedDay = DateTime.now();

  void _dateSelect(DateTime date) {
    setState(() {
      _selectedDay = date;
      _loadDayHistory();
    });
  }

  Future<void> _loadDayHistory() async {
    final target = _selectedDay.toString().split(' ')[0];
    final contents = await repository.getPartHistory(target);

    setState(() {
      dayHistory = contents;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDayHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CalendarView(dateSelect: _dateSelect),
            Expanded(
                flex: 1,
                child: Account(
                  dayHistory: dayHistory,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateScreen(onDate: _selectedDay, mode: "create")));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
