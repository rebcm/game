import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/block_reference_service.dart';

void main() {
  group('BlockReferenceService', () {
    test('generateBlockReferenceJson returns valid JSON', () async {
      final service = BlockReferenceService();
      final json = await service.generateBlockReferenceJson();
      expect(json, isNotNull);
      expect(jsonDecode(json)['blocks'], isA<List>());
    });

    test('validateBlockReferenceJson succeeds with valid JSON', () async {
      final service = BlockReferenceService();
      final json = await service.generateBlockReferenceJson();
      await service.validateBlockReferenceJson(json);
    });
  });
}
