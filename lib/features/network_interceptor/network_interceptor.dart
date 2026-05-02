import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor {
  final Dio _dio;
  final DioAdapter _dioAdapter;

  NetworkInterceptor(this._dio, this._dioAdapter);

  void setupInterceptors() {
    _dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.reply(200, {'data': 'Mocked data'}),
    );

    _dioAdapter.onPost(
      RegExp(r'/api/.*'),
      (server) => server.reply(200, {'data': 'Mocked data'}),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 500) {
            return handler.next(error);
          } else if (error.type == DioExceptionType.connectionTimeout) {
            return handler.next(error);
          }
          return handler.next(error);
        },
      ),
    );
  }

  void simulateTimeout() {
    _dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.throws(404, DioException.connectionTimeout(null, null)),
    );
  }

  void simulate500Error() {
    _dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.reply(500, {'error': 'Internal Server Error'}),
    );
  }
}
