import 'package:game/networking/http_client.dart';

class DataService {
  final CustomHttpClient _httpClient;

  DataService(this._httpClient);

  Future<void> fetchData() async {
    final response = await _httpClient.get(Uri.parse('https://example.com/data'));
    if (response.statusCode == 200) {
      // Process data
    } else {
      // Handle error
    }
  }
}
