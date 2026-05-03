import 'package:sqflite/sqflite.dart';

Future<Database> setupTestDatabase() async {
  return await openDatabase(
    inMemoryDatabasePath,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE worlds (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');
    },
  );
}
