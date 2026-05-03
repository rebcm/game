import 'package:http/http.dart' as http;
import 'package:game/utils/logger/logger.dart';

class PassdriverService {
  Future<http.Response> authenticate(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://example.com/authenticate'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"username": "$username", "password": "$password"}',
      );

      if (response.statusCode == 200) {
        Logger.logInfo('Authentication successful');
        return response;
      } else {
        Logger.logError('Authentication failed', response.statusCode);
        throw Exception('Authentication failed');
      }
    } catch (e) {
      Logger.logError('Error during authentication', e);
      rethrow;
    }
  }

  Future<http.Response> makeRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('https://example.com/$endpoint'));

      if (response.statusCode == 200) {
        Logger.logInfo('Request to $endpoint successful');
        return response;
      } else {
        Logger.logError('Request to $endpoint failed', response.statusCode);
        throw Exception('Request failed');
      }
    } catch (e) {
      Logger.logError('Error during request to $endpoint', e);
      rethrow;
    }
  }
}
