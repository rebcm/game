import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Response> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      return response;
    } on DioException catch (e) {
      throw Exception('Falha ao realizar login: ${e.message}');
    }
  }

  Future<Response> logout(String refreshToken) async {
    try {
      final response = await _dio.post('/auth/logout', data: {
        'refreshToken': refreshToken,
      });
      return response;
    } on DioException catch (e) {
      throw Exception('Falha ao realizar logout: ${e.message}');
    }
  }

  Future<Response> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post('/auth/refresh-token', data: {
        'refreshToken': refreshToken,
      });
      return response;
    } on DioException catch (e) {
      throw Exception('Falha ao atualizar token: ${e.message}');
    }
  }
}
