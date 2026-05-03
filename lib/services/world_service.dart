import 'package:game/database/world_database.dart';
import 'package:game/models/world_model.dart';
import 'package:sqflite/sqflite.dart';

class WorldService {
  final Database _db;

  WorldService(this._db);

  Future<void> createTable() async {
    await WorldDatabase.createTable(_db);
  }

  Future<void> saveWorld(WorldModel world) async {
    await WorldDatabase.insertWorld(_db, world);
  }

  Future<List<WorldModel>> getWorlds() async {
    return await WorldDatabase.getWorlds(_db);
  }
}
