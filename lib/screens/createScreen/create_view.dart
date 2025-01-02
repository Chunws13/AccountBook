import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final DateTime onDate;
  const CreateScreen({super.key, required this.onDate});

  @override
  State<CreateScreen> createState() => _CreateScreen();
}

class _CreateScreen extends State<CreateScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  String stringDate = '';

  Future<void> _addContent() async {
    final content = _contentController.text;
    final value = _valueController.text;

    print('$content, $value');

    _contentController.clear();
    _valueController.clear();
  }

  @override
  void initState() {
    super.initState();
    stringDate = widget.onDate.toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(stringDate),
          Row(
            children: [Text('수입'), Text('지출')],
          ),
          Row(children: [
            Text("의류"),
            Text("식사"),
            Text("주거"),
          ]),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: '출처',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(
              labelText: '금액',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: _addContent, child: Text("취소")),
              ElevatedButton(onPressed: _addContent, child: Text("저장")),
            ],
          )
        ],
      )),
    );
  }
}
