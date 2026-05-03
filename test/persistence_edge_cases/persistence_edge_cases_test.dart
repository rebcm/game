import 'package:flutter_test/flutter_test.dart';
import 'package:game/data/persistence.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('Persistence Edge Cases', () {
    late Database db;

    setUp(() async {
      db = await openDatabase(inMemoryDatabasePath);
    });

    tearDown(() async {
      await db.close();
    });

    test('should insert world name with special characters', () async {
      final worldName = 'Mundo com caracteres especiais !@#$%^&*()';
      await db.insert('worlds', {'name': worldName, 'created_at': DateTime.now().toIso8601String()});
      final result = await db.query('worlds', columns: ['name']);
      expect(result.first['name'], worldName);
    });

    test('should handle ISO8601 timestamp precision', () async {
      final now = DateTime.now();
      final isoString = now.toIso8601String();
      await db.insert('worlds', {'name': 'Test World', 'created_at': isoString});
      final result = await db.query('worlds', columns: ['created_at']);
      final storedDate = DateTime.parse(result.first['created_at'] as String);
      expect(storedDate.millisecondsSinceEpoch, closeTo(now.millisecondsSinceEpoch, 1000));
    });
  });
}
