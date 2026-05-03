import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> uploadData() async {
    // Implement upload logic here
    return http.Response('OK', 200);
  }
}
