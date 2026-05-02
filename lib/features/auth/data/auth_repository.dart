import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Either<String, String>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://example.com/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: '{"email": "", "password": ""}',
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left('Erro ao realizar login');
    }
  }
}
