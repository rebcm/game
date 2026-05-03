import 'package:flutter_test/flutter_test.dart';
import 'package:game/data/migration/migration_service.dart';

void main() {
  group('MigrationService', () {
    test('should load migration script successfully', () async {
      final migrationService = MigrationService();
      final script = await migrationService.loadMigrationScript();
      expect(script, isNotEmpty);
    });
  });
}
