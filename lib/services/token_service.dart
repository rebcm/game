import 'package:http/http.dart' as http;

class TokenService {
  Future<bool> isValidToken(String token) async {
    try {
      final response = await http.get(Uri.parse('https://example.com/validate-token'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> handleTokenError(String token) async {
    if (!await isValidToken(token)) {
      throw Exception('Invalid or insufficient token');
    }
  }
}
