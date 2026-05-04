import 'package:http/http.dart' as http;

class HttpClient {
  Future<http.Response> get(Uri url) async {
    return await http.get(url);
  }
}
