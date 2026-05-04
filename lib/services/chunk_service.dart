import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/chunk_model.dart';
import '../errors/chunk_not_found_error.dart';

class ChunkService {
  Future<ChunkModel> getChunk(String coordinates) async {
    final response = await http.get(Uri.parse('https://example.com/chunk/$coordinates'));

    if (response.statusCode == 200) {
      return ChunkModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw ChunkNotFoundError('Chunk not found');
    } else {
      throw Exception('Failed to load chunk');
    }
  }
}
