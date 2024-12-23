import 'package:flutter/material.dart';

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
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
    {'후원금': 10000},
    {'월급': 17000},
  ];

  @override
  Widget build(BuildContext context) {
    num expenseSum = 0;
    num revenueSum = 0;

    for (var item in expense) {
      item.forEach((key, value) {
        expenseSum += value;
      });
    }

    for (var item in reveneu) {
      item.forEach((key, value) {
        revenueSum += value;
      });
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
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[800]),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: initValue
                ? Text(
                    expenseSum.toString(),
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    revenueSum.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: initValue ? expense.length : reveneu.length,
                  itemBuilder: (context, index) {
                    final item = initValue ? expense[index] : reveneu[index];
                    return Text(item.keys.first);
                  }))
        ],
      ),
    );
  }
}
