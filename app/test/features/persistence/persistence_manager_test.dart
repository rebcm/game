import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_app/features/persistence/persistence_manager.dart';

void main() {
  group('PersistenceManager', () {
    late PersistenceManager persistenceManager;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      persistenceManager = PersistenceManager();
    });

    test('saves data correctly', () async {
      await persistenceManager.saveData('test_data');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('game_data'), 'test_data');
    });

    test('loads data correctly', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('game_data', 'test_data');
      final data = await persistenceManager.loadData();
      expect(data, 'test_data');
    });

    test('returns null when no data is saved', () async {
      final data = await persistenceManager.loadData();
      expect(data, null);
    });
  });
}
