import 'package:flutter/material.dart';
import 'account_view.dart';
import 'calendar_view.dart';
import '../createScreen/create_view.dart';

class CalendarAccount extends StatelessWidget {
  const CalendarAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CalendarView(),
            Expanded(flex: 1, child: Account()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
