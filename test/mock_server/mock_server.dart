import 'package:http/http.dart' as http;
import 'dart:io';

class MockServer {
  HttpServer? _server;

  Future<void> start() async {
    _server = await HttpServer.bind('localhost', 8080);
    _server!.listen((request) async {
      if (request.uri.path == '/401') {
        request.response.statusCode = 401;
      } else if (request.uri.path == '/507') {
        request.response.statusCode = 507;
      } else {
        request.response.statusCode = 200;
      }
      await request.response.close();
    });
  }

  Future<void> stop() async {
    await _server?.close(force: true);
  }
}
