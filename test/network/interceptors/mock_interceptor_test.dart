import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/network/interceptors/mock_interceptor.dart';

void main() {
  late Dio dio;

  setUp(() {
    dio = Dio();
    setupMockInterceptor(dio);
  });

  test('should return mocked data', () async {
    final response = await dio.get('https://example.com/api/data');
    expect(response.data, {'data': 'Mocked data'});
  });

  test('should throw timeout exception', () async {
    expect(
      () async => await dio.get('https://example.com/api/timeout'),
      throwsA(isA<DioException>()),
    );
  });

  test('should return 500 error', () async {
    final response = await dio.get('https://example.com/api/500');
    expect(response.statusCode, 500);
    expect(response.data, {'error': 'Internal Server Error'});
  });
}
