import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'accountBook.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE accountBook(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date DATE,
          classify TEXT,
          content TEXT,
          amount INTEGER,
          tag TEXT
        )
        ''');
      },
    );
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    return 1;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;

    return await db.query('accountBook');
  }

  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    final db = await database;
    return await db
        .update('accountBook', item, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete('accountBook', where: 'id = ?', whereArgs: [id]);
  }
}
