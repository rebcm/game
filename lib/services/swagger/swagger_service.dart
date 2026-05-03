import 'package:http/http.dart' as http;

class SwaggerService {
  Future<http.Response> getDocs() async {
    return await http.get(Uri.parse('http://localhost:8080/api/v1/docs'));
  }

  Future<http.Response> getEndpoints() async {
    return await http.get(Uri.parse('http://localhost:8080/api/v1/endpoints'));
  }
}
