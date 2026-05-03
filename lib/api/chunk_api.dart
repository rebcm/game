import 'package:http/http.dart' as http;
import 'dart:convert';

class ChunkApi {
  final http.Client _client;

  ChunkApi(this._client);

  Future<Chunk> getChunk(int chunkId) async {
    final response = await _client.get(Uri.parse('/chunks/$chunkId'));

    if (response.statusCode == 200) {
      return Chunk.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chunk');
    }
  }

  Future<Chunk> createChunk(Chunk chunk) async {
    final response = await _client.post(
      Uri.parse('/chunks'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(chunk.toJson()),
    );

    if (response.statusCode == 201) {
      return Chunk.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create chunk');
    }
  }
}

class Chunk {
  final int id;
  final String data;

  Chunk({required this.id, required this.data});

  factory Chunk.fromJson(Map<String, dynamic> json) {
    return Chunk(id: json['id'], data: json['data']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
    };
  }
}
