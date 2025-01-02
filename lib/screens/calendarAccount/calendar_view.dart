import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  final Function(DateTime) dateSelect;
  const CalendarView({super.key, required this.dateSelect});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  void pressDate(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.focusedDay = focusedDay;
      this.selectedDay = selectedDay;
    });

    widget.dateSelect(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(2010),
        lastDay: DateTime(2100),
        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          pressDate(selectedDay, focusedDay);
        });
  }
}
