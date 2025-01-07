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
          date DATETIME,
          type TEXT,
          tag TEXT,
          content TEXT,
          amount INTEGER
        )
        ''');
      },
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
