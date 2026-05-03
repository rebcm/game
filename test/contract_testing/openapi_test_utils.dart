import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> testGetRequest(String url, int expectedStatusCode, dynamic expectedResponse) async {
  final response = await http.get(Uri.parse(url));
  expect(response.statusCode, expectedStatusCode);
  final jsonData = jsonDecode(response.body);
  expect(jsonData, expectedResponse);
}
