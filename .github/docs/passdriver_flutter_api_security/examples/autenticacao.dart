import 'package:dio/dio.dart';

class AutenticacaoService {
  final Dio _dio;

  AutenticacaoService(this._dio);

  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        // Armazena token de forma segura
      }
    } on DioException catch (e) {
      // Trata erros de autenticação
    }
  }
}
