import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;

class MockHttpAdapter {
  final DioAdapter _dioAdapter = DioAdapter(dio: http.Client());

  void setTimeoutResponse() {
    _dioAdapter.onGet(
      'https://example.com/api/data',
      (server) => server.reply(408, {'message': 'Timeout'}),
      queryParameters: {},
      headers: {},
    );
  }

  http.Client getClient() {
    return _dioAdapter.dio;
  }
}
