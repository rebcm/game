import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/database/database.dart';

void main() {
  group('Atomic Consistency Tests', () {
    test('Rollback after insertion', () async {
      // Setup
      final database = await Database.init();
      final testData = {'key': 'value'};

      try {
        await database.insert(testData);
        throw Exception('Simulated failure');
      } catch (e) {
        await database.rollback();
      }

      // Verify
      final result = await database.get('key');
      expect(result, isNull);
    });

    test('Successful insertion', () async {
      final database = await Database.init();
      final testData = {'key': 'value'};

      await database.insert(testData);

      final result = await database.get('key');
      expect(result, 'value');
    });
  });
}
