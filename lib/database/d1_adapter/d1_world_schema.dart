import 'package:game/database/world_schema.dart';

class D1WorldSchema {
  static const String tableName = 'worlds';

  static const String createTableQuery = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      id TEXT PRIMARY KEY,
      r2BucketReference TEXT NOT NULL,
      createdAt INTEGER NOT NULL,
      updatedAt INTEGER NOT NULL
    );
  ''';

  static WorldSchema fromD1Row(Map<String, Object?> row) {
    return WorldSchema(
      id: row['id'] as String,
      r2BucketReference: row['r2BucketReference'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch((row['createdAt'] as int)),
      updatedAt: DateTime.fromMillisecondsSinceEpoch((row['updatedAt'] as int)),
    );
  }

  static Map<String, dynamic> toD1Params(WorldSchema world) {
    return {
      'id': world.id,
      'r2BucketReference': world.r2BucketReference,
      'createdAt': world.createdAt.millisecondsSinceEpoch,
      'updatedAt': world.updatedAt.millisecondsSinceEpoch,
    };
  }
}
