import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/artifact_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ArtifactDownloader', () {
    late http.Client client;
    late ArtifactDownloader downloader;

    setUp(() {
      client = MockHttpClient();
      downloader = ArtifactDownloader(client);
    });

    test('downloads artifact successfully', () async {
      final response = http.Response('content', 200);
      when(() => client.get(any())).thenAnswer((_) async => response);

      final result = await downloader.downloadArtifact('http://example.com/artifact', 'destination');
      expect(result, true);
    });

    test('retries on failure', () async {
      final response = http.Response('content', 500);
      when(() => client.get(any())).thenAnswer((_) async => response);

      final result = await downloader.downloadArtifact('http://example.com/artifact', 'destination');
      expect(result, false);
      verify(() => client.get(any())).called(4); // initial + 3 retries
    });
  });
}
