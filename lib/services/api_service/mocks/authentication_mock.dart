import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;

class AuthenticationMock {
  final DioAdapter _dioAdapter;

  AuthenticationMock(this._dioAdapter);

  void mockSuccessfulAuthentication() {
    _dioAdapter.onPost(
      'https://example.com/authenticate',
      (server) => server.reply(
        200,
        {'token': 'fake_token'},
      ),
    );
  }

  void mockFailedAuthentication() {
    _dioAdapter.onPost(
      'https://example.com/authenticate',
      (server) => server.reply(
        401,
        {'error': 'Invalid credentials'},
      ),
    );
  }
}
