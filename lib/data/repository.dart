import 'package:rebcm/data/database.dart';

class Repository {
  final Database _database;

  Repository(this._database);

  Future<void> saveData(String data) async {
    try {
      await _database.insert(data);
      await _database.update(data);
      await _database.commit();
    } catch (_) {
      await _database.rollback();
      rethrow;
    }
  }
}
