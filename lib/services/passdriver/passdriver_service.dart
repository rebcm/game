import 'package:http/http.dart' as http;
import 'package:rebcm/utils/error_handler.dart';

class PassdriverService {
  Future<void> authenticate(String username, String password) async {
    try {
      final response = await http.post(Uri.parse('https://example.com/auth'), body: {'username': username, 'password': password});
      if (response.statusCode != 200) {
        throw AuthException('Authentication failed');
      }
    } catch (e, stackTrace) {
      ErrorHandler.handleError(e, stackTrace);
      rethrow;
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://example.com/data'));
      if (response.statusCode != 200) {
        throw InfraException('Failed to fetch data');
      }
      // Process payload
      if (response.body.isEmpty) {
        throw PayloadException('Empty payload');
      }
    } catch (e, stackTrace) {
      ErrorHandler.handleError(e, stackTrace);
      rethrow;
    }
  }
}
