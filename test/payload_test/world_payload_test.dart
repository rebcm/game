import 'package:test/test.dart';
import 'package:rebcm/models/world_payload.dart';

void main() {
  group('WorldPayload', () {
    test('should throw AssertionError when payload is null', () {
      expect(() => WorldPayload.fromJson(null), throwsAssertionError);
    });

    test('should throw FormatException when payload is empty string', () {
      expect(() => WorldPayload.fromJson(''), throwsFormatException);
    });

    test('should throw FormatException when payload is invalid JSON', () {
      expect(() => WorldPayload.fromJson('{ invalid json }'), throwsFormatException);
    });

    test('should handle special characters in payload fields', () {
      final payload = WorldPayload.fromJson('{"name": "World with special chars !@#$%^&*()"}');
      expect(payload.name, 'World with special chars !@#$%^&*()');
    });

    test('should handle empty fields in payload', () {
      final payload = WorldPayload.fromJson('{"name": ""}');
      expect(payload.name, '');
    });
  });
}
