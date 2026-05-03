import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class MigrationService {
  Future<String> loadMigrationScript() async {
    return await rootBundle.loadString('.github/docs/passdriver_migration/migration_ddl.sql');
  }
}
