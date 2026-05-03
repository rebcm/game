import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service/interceptors/mock_http_interceptor.dart';
import 'package:dio/dio.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MockHttpInterceptor mockHttpInterceptor;

  setUp(() {
    dio = Dio();
    dio.httpClientAdapter = dioAdapter = DioAdapter(dio: dio);
    mockHttpInterceptor = MockHttpInterceptor(dioAdapter);
    mockHttpInterceptor.setupMockInterceptor();
  });

  test('test successful response', () async {
    final response = await dio.get('/api/endpoint');
    expect(response.statusCode, 200);
    expect(response.data, {'data': 'success'});
  });

  test('test timeout response', () async {
    expect(() async => await dio.get('/api/timeout'), throwsException);
  });

  test('test 500 response', () async {
    final response = await dio.get('/api/500');
    expect(response.statusCode, 500);
    expect(response.data, {'error': 'Internal Server Error'});
  });
}
