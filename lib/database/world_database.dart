import 'package:game/models/world_model.dart';
import 'package:sqflite/sqflite.dart';

class WorldDatabase {
  static const String _tableName = 'worlds';
  static const String _columnId = 'id';
  static const String _columnR2 = 'r2';
  static const String _columnTimestamp = 'timestamp';

  static Future<void> createTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName (
            $_columnId INTEGER PRIMARY KEY,
            $_columnR2 TEXT NOT NULL,
            $_columnTimestamp INTEGER NOT NULL
          );
          CREATE INDEX IF NOT EXISTS idx_r2 ON $_tableName ($_columnR2);
          CREATE INDEX IF NOT EXISTS idx_timestamp ON $_tableName ($_columnTimestamp);
        ''');
  }

  static Future<void> insertWorld(Database db, WorldModel world) async {
    await db.insert(_tableName, {
      _columnR2: world.r2,
      _columnTimestamp: world.timestamp,
    });
  }

  static Future<List<WorldModel>> getWorlds(Database db) async {
    final List<Map<String, Object?>> maps = await db.query(_tableName, orderBy: '$_columnTimestamp DESC');
    return List.generate(maps.length, (i) => WorldModel.fromMap(maps[i]));
  }
}
