import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/world_api/models/world_payload_model.dart';

void main() {
  group('WorldPayloadModel', () {
    test('fromJson creates a valid model', () {
      final json = {
        'name': 'Test World',
        'chunkData': [1, 2, 3],
      };
      final model = WorldPayloadModel.fromJson(json);
      expect(model.name, 'Test World');
      expect(model.chunkData, [1, 2, 3]);
    });

    test('toJson returns valid json', () {
      final model = WorldPayloadModel(name: 'Test World', chunkData: [1, 2, 3]);
      final json = model.toJson();
      expect(json['name'], 'Test World');
      expect(json['chunkData'], [1, 2, 3]);
    });
  });
}
