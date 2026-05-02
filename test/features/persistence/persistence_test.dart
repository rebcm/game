import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passdriver/features/persistence/persistence_provider.dart';

void main() {
  group('PersistenceProvider', () {
    test('should save and retrieve value', () async {
      SharedPreferences.setMockInitialValues({});
      final persistenceProvider = PersistenceProvider();
      await persistenceProvider.init();

      await persistenceProvider.setValue('test_key', 'test_value');
      expect(persistenceProvider.getValue('test_key'), 'test_value');
    });
  });
}
