import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rebcm/services/storage/d1_storage.dart';

class ChunkUploader {
  final D1Storage _d1Storage;
  final http.Client _httpClient;

  ChunkUploader(this._d1Storage, this._httpClient);

  Future<void> uploadChunk(String chunkId, List<int> chunkData) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('https://your-r2-storage.com/upload'),
        headers: {
          'Content-Type': 'application/octet-stream',
        },
        body: chunkData,
      );

      if (response.statusCode == 200) {
        await _d1Storage.deleteChunkRecord(chunkId);
      } else {
        throw Exception('Failed to upload chunk');
      }
    } catch (e) {
      await _d1Storage.deleteChunkRecord(chunkId);
      rethrow;
    }
  }
}
