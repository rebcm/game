import 'package:test/test.dart';
import 'package:rebcm/models/world_settings.dart';

void main() {
  group('WorldSettings', () {
    test('fromJson', () {
      final json = {'seed': 1, 'chunkSize': 16, 'renderDistance': 10};
      final settings = WorldSettings.fromJson(json);
      expect(settings.seed, 1);
      expect(settings.chunkSize, 16);
      expect(settings.renderDistance, 10);
    });

    test('toJson', () {
      final settings = WorldSettings(seed: 1, chunkSize: 16, renderDistance: 10);
      final json = settings.toJson();
      expect(json['seed'], 1);
      expect(json['chunkSize'], 16);
      expect(json['renderDistance'], 10);
    });
  });
}
