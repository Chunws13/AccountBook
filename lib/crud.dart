import 'database.dart';

class History {
  final int? id;
  final String date;
  final String type;
  final String tag;
  final String content;
  final int amount;

  History(
      {this.id,
      required this.date,
      required this.type,
      required this.tag,
      required this.content,
      required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'tag': tag,
      'content': content,
      'amount': amount,
    };
  }

  static History fromMap(Map<String, dynamic> map) {
    return History(
        id: map['id'] as int,
        date: map['date'] as String,
        type: map['type'] as String,
        tag: map['tag'] as String,
        content: map['content'] as String,
        amount: map['amount'] as int);
  }
}

class HistoryRepo {
  final dbHelper = DatabaseHelper();

  Future<List<History>> getAllHistory() async {
    final db = await dbHelper.database;
    final contents = await db.query('accountBook');
    return contents.map((content) => History.fromMap(content)).toList();
  }

  Future<List<History>> getPartHistory(String condition) async {
    final db = await dbHelper.database;
    final contents = await db.query('accountBook',
        where: 'date Like ? ', whereArgs: ['%$condition%']);
    return contents.map((content) => History.fromMap(content)).toList();
  }

  Future<int> createHistory(History history) async {
    final db = await dbHelper.database;
    return await db.insert('accountBook', history.toMap());
  }

  Future<int> updateHistory(History history) async {
    final db = await dbHelper.database;
    return await db.update('accountBook', history.toMap(),
        where: 'id = ?', whereArgs: [history.id]);
  }

  Future<int> deleteHistory(History history) async {
    final db = await dbHelper.database;
    return await db
        .delete('accountBook', where: 'id = ?', whereArgs: [history.id]);
  }
}
