import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> testGetRequest(String endpoint, Map<String, dynamic> expectedResponseStructure) async {
  final response = await http.get(Uri.parse('https://example.com$endpoint'));

  expect(response.statusCode, 200);
  final jsonData = jsonDecode(response.body);
  expect(jsonData, isA<Map<String, dynamic>>());
  // Implement a function to validate the response structure against the expected structure
}

Future<void> testPostRequest(String endpoint, Object requestBody, Map<String, dynamic> expectedResponseStructure) async {
  final response = await http.post(Uri.parse('https://example.com$endpoint'), body: jsonEncode(requestBody), headers: {'Content-Type': 'application/json'});

  expect(response.statusCode, 201); // or 200, depending on the API
  final jsonData = jsonDecode(response.body);
  expect(jsonData, isA<Map<String, dynamic>>());
  // Implement a function to validate the response structure against the expected structure
}
