import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> getEndpoint1() async {
    return await http.get(Uri.parse('https://example.com/api/endpoint1'));
  }

  Future<http.Response> postEndpoint2(Map<String, String> body) async {
    return await http.post(Uri.parse('https://example.com/api/endpoint2'), body: body);
  }
}
