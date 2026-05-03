import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive_io.dart';

class ChunkCompressionService {
  Future<Uint8List> compressChunk(Uint8List chunkData) async {
    return GZipEncoder().encode(chunkData);
  }

  Future<Uint8List> decompressChunk(Uint8List compressedData) async {
    return GZipDecoder().decodeBytes(compressedData);
  }

  Future<http.Response> uploadChunk(String url, Uint8List chunkData) async {
    final compressedData = await compressChunk(chunkData);
    return http.post(Uri.parse(url), body: compressedData, headers: {'Content-Encoding': 'gzip'});
  }

  Future<Uint8List> downloadChunk(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.headers['content-encoding'] == 'gzip') {
      return decompressChunk(response.bodyBytes);
    } else {
      return response.bodyBytes;
    }
  }
}
