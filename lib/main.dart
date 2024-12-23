import 'package:flutter/material.dart';
import 'screens/calendarAccount/calendar_account.dart';

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
            // appBar: AppBar(title: Text('Account Book')),
            body: SafeArea(
          child: CalendarAccount(),
        )));
  }
}
