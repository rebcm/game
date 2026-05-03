import 'package:http/http.dart' as http;

class BackendService {
  Future<http.Response> fetchData() async {
    final response = await http.get(Uri.parse('https://example.com/api/data'));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
