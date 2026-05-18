import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHandler {
  Future<Database> getDb() async {
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_db.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        amount REAL NOT NULL,
        transaction_type TEXT NOT NULL,
        id_category INTEGER,
        FOREIGN KEY (id_category) REFERENCES categories (id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        completed INTEGER DEFAULT 0,
        updatedAt TEXT,
        syncStatus TEXT,
        deleted INTEGER DEFAULT 0
      )
    ''');

    final categories = [
      {'name': 'Food'},
      {'name': 'Clothing'},
      {'name': 'Taxes'},
      {'name': 'Salary'},
      {'name': 'Investments'},
      {'name': 'Entertainment'},
      {'name': 'Health'},
      {'name': 'Other'},
    ];

    for (var category in categories) {
      await db.insert(
        'categories',
        category,
        conflictAlgorithm: ConflictAlgorithm.replace, // Opcional: maneja duplicados
      );
    }
  }
}
