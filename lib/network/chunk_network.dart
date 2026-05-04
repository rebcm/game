import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:game/utils/chunk_compression.dart';

class ChunkNetwork {
  static Future<Uint8List> fetchChunk(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ChunkCompression.decompress(response.bodyBytes);
    } else {
      throw Exception('Failed to load chunk');
    }
  }

  static Future<void> sendChunk(String url, Uint8List data) async {
    final compressedData = ChunkCompression.compress(data);
    await http.post(Uri.parse(url), body: compressedData, headers: {'Content-Encoding': 'gzip'});
  }
}
