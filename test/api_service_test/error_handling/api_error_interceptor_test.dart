import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service/error_handling/api_error_interceptor.dart';
import 'package:game/services/api_service/error_handling/api_error_model.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
  });

  test('ApiErrorInterceptor', () async {
    dio.interceptors.add(ApiErrorInterceptor());

    dioAdapter.onGet(
      '/test',
      (server) => server.reply(
        400,
        {'error': 'code', 'message': 'text'},
      ),
    );

    try {
      await dio.get('/test');
      fail('Should throw');
    } on DioException catch (e) {
      expect(e.error, isA<ApiErrorModel>());
      final apiError = e.error as ApiErrorModel;
      expect(apiError.error, 'code');
      expect(apiError.message, 'text');
    }
  });
}
