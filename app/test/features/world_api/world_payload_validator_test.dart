import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/world_api/validators/world_payload_validator.dart';

void main() {
  group('WorldPayloadValidator', () {
    test('validateName returns null for valid name', () {
      final result = WorldPayloadValidator.validateName('Valid Name');
      expect(result, isNull);
    });

    test('validateName returns error for empty name', () {
      final result = WorldPayloadValidator.validateName('');
      expect(result, 'Name is required');
    });

    test('validateName returns error for name longer than 50 characters', () {
      final result = WorldPayloadValidator.validateName('a' * 51);
      expect(result, 'Name must be less than 50 characters');
    });

    test('validateChunkData returns null for valid chunk data', () {
      final result = WorldPayloadValidator.validateChunkData(List<int>.generate(100, (index) => index));
      expect(result, isNull);
    });

    test('validateChunkData returns error for empty chunk data', () {
      final result = WorldPayloadValidator.validateChunkData([]);
      expect(result, 'Chunk data is required');
    });

    test('validateChunkData returns error for chunk data longer than 10000 bytes', () {
      final result = WorldPayloadValidator.validateChunkData(List<int>.generate(10001, (index) => index));
      expect(result, 'Chunk data must be less than 10000 bytes');
    });
  });
}
