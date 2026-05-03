import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../.env.dart';
import '../../models/chunk_model.dart';

class ChunkApiService {
  final String _baseUrl = '${DotEnv.get('API_URL')}/api/worlds';

  Future<ChunkModel?> getChunk(String worldId, int x, int z) async {
    final response = await http.get(Uri.parse('$_baseUrl/$worldId/chunks/$x/$z'));

    if (response.statusCode == 200) {
      return ChunkModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> saveChunk(String worldId, int x, int z, ChunkModel chunk) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$worldId/chunks/$x/$z'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(chunk.toJson()),
    );

    return response.statusCode == 200;
  }
}
