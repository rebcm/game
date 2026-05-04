import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:game/networking/chunk_compressor.dart';

class ChunkRequestHandler {
  Future<Uint8List> fetchChunk(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return ChunkCompressor.decompress(response.bodyBytes);
    } else {
      throw Exception('Failed to load chunk');
    }
  }

  Future<void> sendChunk(String url, Uint8List data) async {
    final compressedData = ChunkCompressor.compress(data);
    await http.post(Uri.parse(url), body: compressedData, headers: {'Content-Encoding': 'gzip'});
  }
}
