import 'package:http/http.dart' as http;
import 'dart:convert';
import 'passdriver_data_model.dart';

class PassdriverDataProvider {
  final String _apiUrl = 'https://example.com/passdriver-api';

  Future<PassdriverDataModel> fetchPassdriverData() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return PassdriverDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load passdriver data');
    }
  }
}
