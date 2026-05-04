import 'package:test/test.dart';
import 'package:game/networking/chunk_request_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:typed_data';

void main() {
  group('ChunkRequestHandler', () {
    test('fetchChunk success', () async {
      final handler = ChunkRequestHandler();
      final mockHttpClient = MockClient((request) async {
        final compressedData = ChunkCompressor.compress(Uint8List.fromList([1, 2, 3]));
        return http.Response.bytes(compressedData, 200);
      });
      http.Client client = mockHttpClient;
      final data = await handler.fetchChunk('http://example.com/chunk');
      expect(data, Uint8List.fromList([1, 2, 3]));
    });

    test('sendChunk', () async {
      final handler = ChunkRequestHandler();
      final mockHttpClient = MockClient((request) async {
        expect(request.headers['Content-Encoding'], 'gzip');
        final decompressedData = ChunkCompressor.decompress(request.bodyBytes);
        expect(decompressedData, Uint8List.fromList([1, 2, 3]));
        return http.Response('', 200);
      });
      http.Client client = mockHttpClient;
      await handler.sendChunk('http://example.com/chunk', Uint8List.fromList([1, 2, 3]));
    });
  });
}
