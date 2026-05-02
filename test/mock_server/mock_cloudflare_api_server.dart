import 'package:http/http.dart' as http;
import 'dart:convert';

class MockCloudflareApiServer {
  static Future<http.Response> handleRequest(http.Request request) async {
    if (request.url.path == '/token-expired') {
      return http.Response('Unauthorized', 401);
    } else if (request.url.path == '/connection-failure') {
      return http.Response('Service Unavailable', 503);
    } else if (request.url.path == '/payload-too-large') {
      return http.Response('Payload Too Large', 413);
    } else {
      return http.Response('Not Found', 404);
    }
  }
}
