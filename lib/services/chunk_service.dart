import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/chunk_model.dart';
import '../errors/chunk_not_found_error.dart';

class ChunkService {
  final String _baseUrl = 'https://example.com/api';

  Future<ChunkModel> getChunk(int x, int z) async {
    final response = await http.get(Uri.parse('$_baseUrl/chunks/$x/$z'));

    if (response.statusCode == 200) {
      return ChunkModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw ChunkNotFoundError.fromCode(404);
    } else {
      throw Exception('Failed to load chunk');
    }
  }

  Future<ChunkModel> fetchChunk(int x, int z) async {
    try {
      return await getChunk(x, z);
    } on ChunkNotFoundError {
      return ChunkModel.empty();
    } catch (e) {
      rethrow;
    }
  }
}
