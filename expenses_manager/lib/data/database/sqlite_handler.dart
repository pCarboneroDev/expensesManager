import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHandler {
  Future<Database> getDb() async {
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_db.db');
    
    //await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, version) async {
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        amount REAL NOT NULL,
        transaction_type TEXT NOT NULL,
        id_category TEXT,
        FOREIGN KEY (id_category) REFERENCES categories (id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        entityType TEXT NOT NULL,
        entityId TEXT NOT NULL,
        operation TEXT NOT NULL,
        payload TEXT,
        createdAt TEXT NOT NULL,
        attempts INTEGER DEFAULT 0,
        status TEXT NOT NULL
      )
    ''');

    final categories = [
      {'id': "cat001", 'name': 'Food'},
      {'id': "cat002", 'name': 'Clothing'},
      {'id': "cat003", 'name': 'Taxes'},
      {'id': "cat004", 'name': 'Salary'},
      {'id': "cat005", 'name': 'Investments'},
      {'id': "cat006", 'name': 'Entertainment'},
      {'id': "cat007", 'name': 'Health'},
      {'id': "cat008", 'name': 'Other'},
    ];

    for (var category in categories) {
      await db.insert(
        'categories',
        category,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}