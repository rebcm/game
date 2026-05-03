import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;

class MockHttpInterceptor {
  final DioAdapter _dioAdapter;

  MockHttpInterceptor(this._dioAdapter);

  void setupMockInterceptor() {
    _dioAdapter.onGet(
      RegExp(r'/api/endpoint'),
      (server) => server.reply(
        200,
        {'data': 'success'},
      ),
    );

    _dioAdapter.onGet(
      RegExp(r'/api/timeout'),
      (server) => server.throws(404, 'Not Found'),
    );

    _dioAdapter.onGet(
      RegExp(r'/api/500'),
      (server) => server.reply(
        500,
        {'error': 'Internal Server Error'},
      ),
    );
  }
}
