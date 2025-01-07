import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../crud.dart';

class CreateScreen extends StatefulWidget {
  final DateTime onDate;
  final String mode;
  const CreateScreen({super.key, required this.onDate, required this.mode});

  @override
  State<CreateScreen> createState() => _CreateScreen();
}

class _CreateScreen extends State<CreateScreen> {
  final repository = HistoryRepo();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<String> _tagList = ['의류', '주거', '식사', '유흥', '기타'];
  late String _selectedTag;

  void _tagSelect(String tag) {
    setState(() {
      _selectedTag = tag;
    });
  }

  final List<String> _typeList = ['수입', '지출'];
  late String _selectedType;

  void _typeSelect(amount) {
    setState(() {
      _selectedType = amount;
    });
  }

  String stringDate = '';

  Future<void> _addContent() async {
    final content = _contentController.text;
    final amount = int.parse(_amountController.text);

    if (content.isNotEmpty && !amount.isNaN) {
      if (widget.mode == 'create') {
        final String dateString = widget.onDate.toString().split(' ')[0];
        final newHistory = History(
          date: dateString,
          type: _selectedType,
          tag: _selectedTag,
          content: content,
          amount: amount,
        );
        await repository.createHistory(newHistory);
      }
    }

    _contentController.clear();
    _amountController.clear();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    stringDate = widget.onDate.toString().split(' ')[0];
    _selectedTag = _tagList[0];
    _selectedType = _typeList[0];
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
              child: RevenueAndSpend(
                typeSelect: _typeSelect,
                typeList: _typeList,
                selectedType: _selectedType,
              ),
            ),
            Expanded(
              flex: 1,
              child: SelectTag(
                tagSelect: _tagSelect,
                selectedTag: _selectedTag,
                tagList: _tagList,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                  ],
                  controller: _amountController,
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
  final String selectedTag;
  final List<String> tagList;

  const SelectTag({
    super.key,
    required this.tagSelect,
    required this.selectedTag,
    required this.tagList,
  });

  @override
  State<SelectTag> createState() => _SelectTagState();
}

class _SelectTagState extends State<SelectTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.tagList.map((item) {
          return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => widget.tagSelect(item),
                child: FractionallySizedBox(
                    heightFactor: 0.7,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: widget.selectedTag == item
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
  final Function(String) typeSelect;
  final String selectedType;
  final List<String> typeList;

  const RevenueAndSpend({
    super.key,
    required this.typeSelect,
    required this.selectedType,
    required this.typeList,
  });

  @override
  State<RevenueAndSpend> createState() => _RevenueAndSpendState();
}

class _RevenueAndSpendState extends State<RevenueAndSpend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.typeList.map((item) {
          return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => widget.typeSelect(item),
                child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: item == widget.selectedType
                                ? Colors.amber
                                : null),
                        child: Center(child: Text(item)))),
              ));
        }).toList(),
      ),
    );
  }
}
