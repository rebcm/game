import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:passdriver/features/network_interceptor/network_interceptor.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late NetworkInterceptor networkInterceptor;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    networkInterceptor = NetworkInterceptor(dio, dioAdapter);
    networkInterceptor.setupInterceptors();
  });

  test('simulates timeout', () async {
    networkInterceptor.simulateTimeout();
    expect(
      () async => await dio.get('/api/test'),
      throwsA(isA<DioException>()),
    );
  });

  test('simulates 500 error', () async {
    networkInterceptor.simulate500Error();
    final response = await dio.get('/api/test');
    expect(response.statusCode, 500);
  });
}
