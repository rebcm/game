import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service/interceptors/mock_api_interceptor.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MockApiInterceptor interceptor;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    interceptor = MockApiInterceptor(dio, dioAdapter);
    interceptor.setupMocks();
    dio.interceptors.add(interceptor);
  });

  test('test successful mocked request', () async {
    final response = await dio.get('/api/test');
    expect(response.statusCode, 200);
    expect(response.data, {'data': 'Mocked data'});
  });

  test('test 500 error', () async {
    expect(
      () async => await dio.get('/api/error/500'),
      throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'statusCode', 500)),
    );
  });

  test('test timeout', () async {
    dio.options.connectTimeout = const Duration(seconds: 1);
    expect(
      () async => await dio.get('/api/timeout'),
      throwsA(isA<DioException>()),
    );
  });
}
