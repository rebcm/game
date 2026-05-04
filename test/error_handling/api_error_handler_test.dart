import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:game/services/error_handling/api_error.dart';
import 'package:game/services/error_handling/api_error_handler.dart';

void main() {
  group('ApiErrorHandler', () {
    test('deve tratar DioError com dados de erro válidos', () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: {'code': 'test_code', 'message': 'test_message'},
        statusCode: 400,
      );
      final dioException = DioException(requestOptions: RequestOptions(path: '/test'), response: response);
      final apiError = ApiErrorHandler.handleDioError(dioException);
      expect(apiError.code, 'test_code');
      expect(apiError.message, 'test_message');
    });

    test('deve tratar DioError sem dados de erro', () {
      final dioException = DioException(requestOptions: RequestOptions(path: '/test'));
      final apiError = ApiErrorHandler.handleDioError(dioException);
      expect(apiError.code, 'network_error');
    });
  });
}
