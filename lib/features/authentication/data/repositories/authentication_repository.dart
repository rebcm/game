import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthenticationRepository {
  String? _token;

  String? get token => _token;

  Future<void> saveToken(String token) async {
    _token = token;
  }

  Future<bool> isTokenValid() async {
    if (_token == null) return false;
    try {
      final jwt = JWT.verify(_token!, secret: 'your_secret_key_here');
      return jwt.isNotExpired;
    } on JWTExpiredException {
      return false;
    } on JWTException {
      return false;
    }
  }
}
