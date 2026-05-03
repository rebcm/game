import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';

class NetworkInterceptor {
  final DioAdapter _dioAdapter;

  NetworkInterceptor(this._dioAdapter);

  Future<http.Response> interceptRequest(http.Request request) async {
    try {
      final response = await http.Client().send(request);
      return http.Response.fromStream(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return http.Response('', 408); // Request Timeout
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return http.Response('', 504); // Gateway Timeout
      } else {
        return http.Response('', 500); // Internal Server Error
      }
    }
  }

  void simulateTimeout() {
    _dioAdapter.onGet(RegExp(r'/timeout'), (server) => server.reply(408, {}));
  }

  void simulateServerError() {
    _dioAdapter.onGet(RegExp(r'/5xx'), (server) => server.reply(500, {}));
  }
}
