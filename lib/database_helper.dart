import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'calculator.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE histories(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        data TEXT,
        hasil TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  // Create new histori
  static Future<int> createHistory(String? data, String? hasil) async {
    final db = await DatabaseHelper.db();
    final datanya = {'data': data, 'hasil': hasil};
    final id = await db.insert('histories', datanya,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getHistories() async {
    final db = await DatabaseHelper.db();
    return db.query('histories', orderBy: "id");
  }
}
