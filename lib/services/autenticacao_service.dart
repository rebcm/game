import 'package:dio/dio.dart';

class AutenticacaoService {
  final Dio _dio;

  AutenticacaoService(this._dio);

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioException catch (e) {
      print('Erro ao realizar login: $e');
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } on DioException catch (e) {
      print('Erro ao realizar logout: $e');
    }
  }
}
