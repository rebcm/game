import 'package:http/http.dart' as http;

class AuthMiddleware {
  static Future<bool> validateUserId(http.Request request) async {
    final userId = request.headers['X-User-Id'];
    return userId != null && userId.isNotEmpty;
  }
}
