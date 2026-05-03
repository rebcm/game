import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:your_app/api/chunk_api.dart';

void main() {
  group('Chunk API Contract Test', () {
    late http.Client client;
    late ChunkApi chunkApi;

    setUp(() {
      client = http.Client();
      chunkApi = ChunkApi(client);
    });

    test('GET /chunks/{chunkId} returns 200 for valid chunkId', () async {
      final response = await client.get(Uri.parse('http://localhost:8080/chunks/1'));

      expect(response.statusCode, 200);
      final chunk = Chunk.fromJson(jsonDecode(response.body));
      expect(chunk.id, 1);
    });

    test('POST /chunks returns 201 for valid chunk data', () async {
      final chunk = Chunk(id: 2, data: 'new chunk data');
      final response = await client.post(
        Uri.parse('http://localhost:8080/chunks'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(chunk.toJson()),
      );

      expect(response.statusCode, 201);
      final createdChunk = Chunk.fromJson(jsonDecode(response.body));
      expect(createdChunk.id, isNotNull);
    });
  });
}
