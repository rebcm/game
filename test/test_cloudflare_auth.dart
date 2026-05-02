import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final token = const String.fromEnvironment('CLOUDFLARE_TOKEN');
  if (token.isEmpty) {
    throw Exception('CLOUDFLARE_TOKEN is not set');
  }

  final response = await http.get(
    Uri.parse('https://api.cloudflare.com/client/v4/user/tokens/verify'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to verify token: ${response.statusCode}');
  }

  final jsonData = jsonDecode(response.body);
  if (!(jsonData['result']['status'] == 'active')) {
    throw Exception('Token is not active');
  }

  print('Token is valid and active');
}
