import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late AuthService authService;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    authService = AuthService(dio);
  });

  group('AuthService', () {
    test('login com sucesso', () async {
      dioAdapter.onPost('/auth/login', data: {'username': 'user', 'password': 'pass'}, (server) {
        server.reply(200, {'token': 'jwt-token', 'refreshToken': 'refresh-token'});
      });

      final response = await authService.login('user', 'pass');
      expect(response.statusCode, 200);
      expect(response.data['token'], 'jwt-token');
      expect(response.data['refreshToken'], 'refresh-token');
    });

    test('logout com sucesso', () async {
      dioAdapter.onPost('/auth/logout', data: {'refreshToken': 'refresh-token'}, (server) {
        server.reply(200, {'success': true});
      });

      final response = await authService.logout('refresh-token');
      expect(response.statusCode, 200);
      expect(response.data['success'], true);
    });

    test('refresh token com sucesso', () async {
      dioAdapter.onPost('/auth/refresh-token', data: {'refreshToken': 'refresh-token'}, (server) {
        server.reply(200, {'token': 'new-jwt-token', 'refreshToken': 'new-refresh-token'});
      });

      final response = await authService.refreshToken('refresh-token');
      expect(response.statusCode, 200);
      expect(response.data['token'], 'new-jwt-token');
      expect(response.data['refreshToken'], 'new-refresh-token');
    });
  });
}
