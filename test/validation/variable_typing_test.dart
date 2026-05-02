import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/config_service.dart';

void main() {
  group('Variable Typing Validation', () {
    test('validate string variables', () {
      final config = ConfigService();
      // Assuming loadConfig is called before accessing variables
      expect(config.stringVariable, isA<String>());
    });

    test('validate boolean variables', () {
      final config = ConfigService();
      expect(config.booleanVariable, isA<bool>());
    });

    test('validate number variables', () {
      final config = ConfigService();
      expect(config.numberVariable, isA<num>());
    });
  });
}
