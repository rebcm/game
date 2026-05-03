import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> getArtefato() async {
    try {
      final response = await _dio.get('https://example.com/api/artefato');
      return response;
    } on DioException catch (e) {
      throw Exception('Erro ao buscar artefato: ${e.message}');
    }
  }
}
