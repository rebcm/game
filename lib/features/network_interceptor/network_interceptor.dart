import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor {
  final Dio _dio;
  final DioAdapter _dioAdapter;

  NetworkInterceptor(this._dio, this._dioAdapter);

  void setInterceptor() {
    _dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.reply(200, {'data': 'success'}),
    );

    _dioAdapter.onPost(
      RegExp(r'/api/.*'),
      (server) => server.reply(200, {'data': 'success'}),
    );

    _dio.httpClientAdapter = _dioAdapter;
  }

  void simulateTimeout() {
    _dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.throws(404, DioException.connectionError(
        requestOptions: RequestOptions(path: '/api/test'),
      )),
    );
  }

  void simulate500Error() {
    _dioAdapter.onGet(
      RegExp(r'/api/.*'),
      (server) => server.reply(500, {'error': 'Internal Server Error'}),
    );
  }
}
