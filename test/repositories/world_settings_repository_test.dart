import 'package:test/test.dart';
import 'package:rebcm/repositories/world_settings_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('WorldSettingsRepository', () {
    late WorldSettingsRepository repository;
    late MockHttpClient client;

    setUp(() {
      client = MockHttpClient();
      repository = WorldSettingsRepository('http://example.com', client: client);
    });

    test('getWorldSettings success', () async {
      when(() => client.get(any())).thenAnswer((_) async => http.Response('{"seed": 1, "chunkSize": 16, "renderDistance": 10}', 200));
      final settings = await repository.getWorldSettings('worldId');
      expect(settings.seed, 1);
      expect(settings.chunkSize, 16);
      expect(settings.renderDistance, 10);
    });

    test('updateWorldSettings success', () async {
      when(() => client.put(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async => http.Response('{"seed": 1, "chunkSize": 16, "renderDistance": 10}', 200));
      final settings = WorldSettings(seed: 1, chunkSize: 16, renderDistance: 10);
      final updatedSettings = await repository.updateWorldSettings('worldId', settings);
      expect(updatedSettings.seed, 1);
      expect(updatedSettings.chunkSize, 16);
      expect(updatedSettings.renderDistance, 10);
    });
  });
}
