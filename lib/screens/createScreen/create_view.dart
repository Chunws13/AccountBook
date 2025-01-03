import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final DateTime onDate;
  final String mode;
  const CreateScreen({super.key, required this.onDate, required this.mode});

  @override
  State<CreateScreen> createState() => _CreateScreen();
}

class _CreateScreen extends State<CreateScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  String stringDate = '';

  String? _selectedTag;

  Future<void> _addContent() async {
    final content = _contentController.text;
    final value = _valueController.text;

    print('$content, $value, ${widget.mode}');

    _contentController.clear();
    _valueController.clear();
  }

  void _tagSelect(String tag) {
    setState(() {
      _selectedTag = tag;
    });
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
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  stringDate,
                  style: TextStyle(fontSize: 24),
                ))),
            Expanded(
              flex: 1,
              child: RevenueAndSpend(),
            ),
            Expanded(
              flex: 1,
              child: SelectTag(
                tagSelect: _tagSelect,
                initTag: _selectedTag,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
                child: TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: '출처',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
                child: TextField(
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText: '금액',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.amber),
                margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("취소")),
                    ElevatedButton(onPressed: _addContent, child: Text("저장")),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class SelectTag extends StatefulWidget {
  final Function(String) tagSelect;
  final String? initTag;

  const SelectTag({super.key, required this.tagSelect, required this.initTag});

  @override
  State<SelectTag> createState() => _SelectTagState();
}

class _SelectTagState extends State<SelectTag> {
  final List<String> tagList = ['의류', '주거', '식사', '유흥', '기타'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tagList.map((item) {
          return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => widget.tagSelect(item),
                child: FractionallySizedBox(
                    heightFactor: 0.7,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: widget.initTag == item
                                ? Colors.blueAccent
                                : null),
                        child: Center(child: Text(item)))),
              ));
        }).toList(),
      ),
    );
  }
}

class RevenueAndSpend extends StatefulWidget {
  const RevenueAndSpend({
    super.key,
  });

  @override
  State<RevenueAndSpend> createState() => _RevenueAndSpendState();
}

class _RevenueAndSpendState extends State<RevenueAndSpend> {
  final List<String> classify = ['수입', '지출'];
  String? selectValue;

  @override
  void initState() {
    super.initState();
    selectValue = classify[0];
  }

  void selectCategory(value) {
    setState(() {
      selectValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: classify.map((item) {
          return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => selectCategory(item),
                child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: item == selectValue ? Colors.amber : null),
                        child: Center(child: Text(item)))),
              ));
        }).toList(),
      ),
    );
  }
}
