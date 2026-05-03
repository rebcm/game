import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service/mocks/authentication_mock.dart';
import 'package:dio/dio.dart';

void main() {
  late Dio _dio;
  late DioAdapter _dioAdapter;
  late AuthenticationMock _authenticationMock;

  setUp(() {
    _dio = Dio();
    _dioAdapter = DioAdapter(dio: _dio);
    _dio.httpClientAdapter = _dioAdapter;
    _authenticationMock = AuthenticationMock(_dioAdapter);
  });

  test('successful authentication', () async {
    _authenticationMock.mockSuccessfulAuthentication();
    final response = await _dio.post('https://example.com/authenticate');
    expect(response.statusCode, 200);
    expect(response.data['token'], 'fake_token');
  });

  test('failed authentication', () async {
    _authenticationMock.mockFailedAuthentication();
    final response = await _dio.post('https://example.com/authenticate');
    expect(response.statusCode, 401);
    expect(response.data['error'], 'Invalid credentials');
  });
}
