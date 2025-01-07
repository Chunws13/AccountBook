import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../crud.dart';

class Account extends StatefulWidget {
  final List<History> dayHistory;
  const Account({super.key, required this.dayHistory});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {
  final formatter = NumberFormat('#,##0', 'ko_KR');
  bool initValue = true;

  String truncateText(String text) {
    if (text.length > 10) {
      return '${text.substring(0, 10)}...';
    }
    return text;
  }

  String truncateInt(num reveneu) {
    if (reveneu > 1000000) {
      String million = formatter.format(reveneu ~/ 1000000);
      num remain = reveneu % 1000000;
      return '$million.$remain 백만';
    }
    return formatter.format(reveneu);
  }

  @override
  Widget build(BuildContext context) {
    List<History> expense = [];
    List<History> reveneu = [];
    num expenseSum = 0;
    num revenueSum = 0;

    for (var content in widget.dayHistory) {
      if (content.type == '수입') {
        reveneu.add(content);
        revenueSum += content.amount;
      } else {
        expense.add(content);
        expenseSum += content.amount;
      }
    }

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
                  itemCount: initValue ? expense.length : reveneu.length,
                  itemBuilder: (context, index) {
                    final item = initValue ? expense[index] : reveneu[index];
                    return Card(
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
                    );
                  }))
        ],
      ),
    );
  }
}
