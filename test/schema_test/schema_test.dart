import 'package:test/test.dart';
import 'package:game/data/schema.dart';

void main() {
  group('Schema Tests', () {
    test('should not allow null values in NOT NULL fields', () {
      // Implementação do teste
      expect(() => Schema.validate(null), throwsA(isA<Exception>()));
    });

    test('should not allow duplicate primary keys', () {
      // Implementação do teste
      expect(() => Schema.insertDuplicatePrimaryKey(), throwsA(isA<Exception>()));
    });

    test('should validate data according to business rules', () {
      // Implementação do teste
      expect(Schema.validateData('valid_data'), isTrue);
      expect(Schema.validateData('invalid_data'), isFalse);
    });
  });
}
