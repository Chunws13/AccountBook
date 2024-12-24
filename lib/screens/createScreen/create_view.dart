import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SelectTag(),
        ],
      )),
    );
  }
}

class SelectTag extends StatefulWidget {
  const SelectTag({super.key});

  @override
  State<SelectTag> createState() => _SelectTag();
}

class _SelectTag extends State<SelectTag> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("의류"),
      Text("식사사"),
      Text("주거"),
    ]);
  }
}
