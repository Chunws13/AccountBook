import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Account Book',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('Account Book')),
          body: Column(children: [
            CalendarView(),
            Account(),
          ]),
        ));
  }
}

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  bool initValue = true;

  List<Map<String, int>> expense = [
    {'교통비': 1000},
    {'점심값': 10000}
  ];

  List<Map<String, int>> reveneu = [
    {'후원금': 10000},
    {'월급': 17000}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 3),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initValue = true;
                    });
                  },
                  child: Text('지출', style: TextStyle(fontSize: 18)),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initValue = false;
                    });
                  },
                  child: Text(
                    '수입',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              itemCount: initValue ? expense.length : reveneu.length,
              itemBuilder: (context, index) {
                final item = initValue ? expense[index] : reveneu[index];
                return ListTile(
                  title: Text(item.toString()),
                );
              })
        ],
      ),
    );
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  void pressDate(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.focusedDay = focusedDay;
      this.selectedDay = selectedDay;
    });
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
