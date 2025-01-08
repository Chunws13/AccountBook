import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../crud.dart';

class Account extends StatefulWidget {
  final List<History> dayHistory;
  final DateTime selectedDay;
  const Account(
      {super.key, required this.dayHistory, required this.selectedDay});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  final formatter = NumberFormat('#,##0', 'ko_KR');
  final repository = HistoryRepo();
  List<History> expense = [];
  List<History> revenue = [];
  num expenseSum = 0;
  num revenueSum = 0;

  bool initValue = true;

  String truncateText(String text) {
    if (text.length > 10) {
      return '${text.substring(0, 10)}...';
    }
    return text;
  }

  String truncateInt(num revenue) {
    if (revenue > 1000000) {
      String million = formatter.format(revenue ~/ 1000000);
      num remain = revenue % 1000000;
      return '$million.$remain 백만';
    }
    return formatter.format(revenue);
  }

  void deleteCard(int index, String type) {
    if (type == '수입') {
      revenueSum -= revenue[index].amount;
      revenue.removeAt(index);
    } else {
      expenseSum -= expense[index].amount;
      expense.removeAt(index);
    }
  }

  @override
  void didUpdateWidget(covariant Account oldWidget) {
    super.didUpdateWidget(oldWidget);
    // selectedDay가 변경되면 새로운 데이터를 로드하고 화면을 업데이트
    if (widget.selectedDay != oldWidget.selectedDay) {
      _loadDayHistory();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDayHistory();
  }

  Future<void> _loadDayHistory() async {
    final String dateString = widget.selectedDay.toString().split(' ')[0];
    final dayHistory = await repository.getPartHistory(dateString);

    expense.clear();
    revenue.clear();
    expenseSum = 0;
    revenueSum = 0;

    for (var content in dayHistory) {
      if (content.type == '수입') {
        revenue.add(content);
        revenueSum += content.amount;
      } else {
        expense.add(content);
        expenseSum += content.amount;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 3),
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
          Container(
            margin: EdgeInsets.only(bottom: 8),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[800]),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: initValue
                ? Text(
                    formatter.format(expenseSum),
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    formatter.format(revenueSum),
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: initValue ? expense.length : revenue.length,
              itemBuilder: (context, index) {
                final item = initValue ? expense[index] : revenue[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await repository.deleteHistory(item);
                    setState(() {
                      initValue
                          ? deleteCard(index, '지출')
                          : deleteCard(index, '수입');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Center(child: Text('삭제되었습니다.'))),
                      );
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              truncateText(item.content),
                            ),
                            Text(
                              truncateInt(item.amount),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
