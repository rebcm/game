import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rebcm/api/world_endpoint.dart';

void main() {
  group('WorldEndpoint', () {
    test('validates name length', () async {
      final endpoint = WorldEndpoint();
      expect(await endpoint.validatePayload('ab', []), isFalse);
      expect(await endpoint.validatePayload('a' * 21, []), isFalse);
      expect(await endpoint.validatePayload('valid_name', []), isTrue);
    });

    test('validates chunk data size', () async {
      final endpoint = WorldEndpoint();
      final largeChunkData = List<int>.generate(1024 * 1024 + 1, (i) => i);
      expect(await endpoint.validatePayload('valid_name', largeChunkData), isFalse);
      expect(await endpoint.validatePayload('valid_name', []), isTrue);
    });

    test('checks for duplicate names', () async {
      final endpoint = WorldEndpoint();
      final client = MockClient((request) async {
        if (request.url.path == '/api/worlds' && request.method == 'POST') {
          final body = jsonDecode(await request.finalize().bytesToString());
          if (body['name'] == 'duplicate_name') {
            return http.Response('Name already exists', 400);
          }
        }
        return http.Response('', 201);
      });
      http.Client _client = client;
      // Simulate duplicate name check
      expect(await endpoint.validatePayload('duplicate_name', []), isFalse);
    });
  });
}
