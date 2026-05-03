import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockApiInterceptor extends Interceptor {
  final Dio dio;
  final DioAdapter dioAdapter;

  MockApiInterceptor(this.dio, this.dioAdapter);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // No-op for now, can be extended later if needed
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle Dio exceptions here if needed
    return handler.next(err);
  }

  void setupMocks() {
    dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.reply(200, {'data': 'Mocked data'}),
    );

    dioAdapter.onGet(
      '/api/error/500',
      (server) => server.reply(500, {'error': 'Internal Server Error'}),
    );

    dioAdapter.onGet(
      '/api/timeout',
      (server) async {
        await Future.delayed(const Duration(seconds: 10));
        server.reply(200, {'data': 'Timeout test'});
      },
    );
  }
}
