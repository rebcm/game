import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class CloudflareMockClient {
  final http.MockClient _client;

  CloudflareMockClient(this._client);

  static CloudflareMockClient withStatus(int statusCode, String body) {
    final mockClient = http.MockClient((request) async {
      return http.Response(body, statusCode);
    });
    return CloudflareMockClient(mockClient);
  }

  static CloudflareMockClient with401() {
    return withStatus(401, '{"error":"Token expirado"}');
  }

  static CloudflareMockClient with503() {
    return withStatus(503, '{"error":"Falha de conexão"}');
  }

  static CloudflareMockClient with413() {
    return withStatus(413, '{"error":"Payload Too Large"}');
  }
}
