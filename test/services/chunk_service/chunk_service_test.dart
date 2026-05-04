import 'package:test/test.dart';
import 'package:game/services/chunk_service/chunk_service.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'dart:typed_data';

void main() {
  test('fetchChunk', () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onGet('/chunks/0/0', (server) {
      final compressedData = ChunkCompression.compress(Uint8List.fromList([1, 2, 3]));
      return server.reply(200, compressedData);
    });
    final chunkService = ChunkService(dio);
    final data = await chunkService.fetchChunk(0, 0);
    expect(data, Uint8List.fromList([1, 2, 3]));
  });

  test('sendChunk', () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost('/chunks/0/0', (server) {
      return server.reply(200);
    });
    final chunkService = ChunkService(dio);
    await chunkService.sendChunk(0, 0, Uint8List.fromList([1, 2, 3]));
  });
}
