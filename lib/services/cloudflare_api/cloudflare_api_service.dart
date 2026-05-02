import 'package:http/http.dart' as http;

class CloudflareApiService {
  Future<http.Response> post(String url, Map<String, String> headers, String body) async {
    return await http.post(Uri.parse(url), headers: headers, body: body);
  }
}
