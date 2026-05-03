import 'package:drift/drift.dart';
import 'package:rebcm/database/drift/tables/worlds_table.dart';

@DriftDatabase(tables: [Worlds])
class WorldsDatabase extends _$WorldsDatabase {
  WorldsDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
