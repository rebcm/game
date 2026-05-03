// OpenAPI client implementation
import 'package:dio/dio.dart';

class OpenApiClient {
  final Dio _dio;

  OpenApiClient(this._dio);

  Future<Response> getDocs() async {
    return await _dio.get('/docs');
  }

  Future<Response> getBlocks() async {
    return await _dio.get('/api/v1/blocks');
  }

  Future<Response> createBlock(Map<String, dynamic> block) async {
    return await _dio.post('/api/v1/blocks', data: block);
  }
}
