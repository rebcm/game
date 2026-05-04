import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockInterceptor extends Interceptor {
  final DioAdapter _dioAdapter;

  MockInterceptor(this._dioAdapter);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _dioAdapter.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

void setupMockInterceptor(Dio dio) {
  final dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;

  dioAdapter.onGet(
    'https://example.com/api/data',
    (server) => server.reply(200, {'data': 'Mocked data'}),
  );

  dioAdapter.onGet(
    'https://example.com/api/timeout',
    (server) => server.throws(404, DioException.connectionTimeout(
      requestOptions: RequestOptions(path: 'https://example.com/api/timeout'),
    )),
  );

  dioAdapter.onGet(
    'https://example.com/api/500',
    (server) => server.reply(500, {'error': 'Internal Server Error'}),
  );

  dio.interceptors.add(MockInterceptor(dioAdapter));
}
