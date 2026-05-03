import 'package:http/http.dart' as http;
import 'package:rebcm/networking/http_client.dart';

class HttpClientFactory {
  static CustomHttpClient createHttpClient() {
    return CustomHttpClient(http.Client());
  }
}
