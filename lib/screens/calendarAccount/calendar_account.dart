import 'package:flutter/material.dart';
import 'account_view.dart';
import 'calendarView.dart';

class CalendarAccount extends StatelessWidget {
  const CalendarAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CalendarView(), Expanded(flex: 1, child: Account())],
    );
  }
}
