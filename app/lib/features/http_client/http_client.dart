import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'http_interceptor.dart';

class HttpClient {
  static http.Client getClient() {
    return InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
      requestTimeout: Duration(seconds: 10),
    );
  }
}
