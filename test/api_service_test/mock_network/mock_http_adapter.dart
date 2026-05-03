import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;

class MockHttpAdapter {
  final DioAdapter _dioAdapter = DioAdapter(dio: Dio());

  void setTimeoutError() {
    _dioAdapter.onGet(
      'https://example.com/api/data',
      (server) => server.reply(408, {'message': 'Timeout'}),
      queryParams: {'delay': 'true'},
    );
  }

  void setSuccessResponse() {
    _dioAdapter.onGet(
      'https://example.com/api/data',
      (server) => server.reply(200, {'message': 'Success'}),
    );
  }

  DioAdapter get dioAdapter => _dioAdapter;
}
