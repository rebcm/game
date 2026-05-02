import 'package:http/http.dart' as http;

class CloudflareTokenService {
  Future<bool> isValidToken(String token) async {
    try {
      final response = await http.get(Uri.parse('https://example.com'), headers: {
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
