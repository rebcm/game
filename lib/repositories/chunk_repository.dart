import 'package:http/http.dart' as http;
import 'package:rebcm/models/chunk.dart';

class ChunkRepository {
  final http.Client _client;

  ChunkRepository(this._client);

  Future<Chunk> getChunk(String worldId, int x, int z) async {
    final response = await _client.get(Uri.parse('/api/worlds/$worldId/chunks/$x/$z'));

    if (response.statusCode == 200) {
      return Chunk.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chunk');
    }
  }

  Future<void> saveChunk(String worldId, int x, int z, Chunk chunk) async {
    final response = await _client.put(
      Uri.parse('/api/worlds/$worldId/chunks/$x/$z'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chunk.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save chunk');
    }
  }
}
