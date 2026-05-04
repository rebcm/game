import 'package:game/utils/compression/chunk_compression.dart';
import 'package:dio/dio.dart';

class ChunkService {
  final Dio _dio;

  ChunkService(this._dio);

  Future<Uint8List> fetchChunk(int x, int z) async {
    final response = await _dio.get('/chunks/$x/$z');
    return ChunkCompression.decompress(response.data);
  }

  Future<void> sendChunk(int x, int z, Uint8List data) async {
    final compressedData = ChunkCompression.compress(data);
    await _dio.post('/chunks/$x/$z', data: compressedData);
  }
}
