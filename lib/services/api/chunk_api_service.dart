import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/chunk_model.dart';

class ChunkApiService {
  final http.Client _client;

  ChunkApiService(this._client);

  Future<ChunkModel?> getChunk(String worldId, int x, int z) async {
    final response = await _client.get(Uri.parse('/api/worlds/$worldId/chunks/$x/$z'));

    if (response.statusCode == 200) {
      return ChunkModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> saveChunk(String worldId, int x, int z, ChunkModel chunk) async {
    final response = await _client.put(
      Uri.parse('/api/worlds/$worldId/chunks/$x/$z'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chunk.toJson()),
    );

    return response.statusCode == 200;
  }
}
