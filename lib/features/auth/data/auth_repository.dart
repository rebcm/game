import Intl.message('package:dartz/dartz.dart');
import Intl.message('package:http/http.dart') as http;

class AuthRepository {
  Future<Either<String, String>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(Intl.message('https://example.com/api/auth/login')),
      headers: {Intl.message('Content-Type'): Intl.message('application/json')},
      body: Intl.message('{"email": "", "password": ""}'),
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(Intl.message('Erro ao realizar login'));
    }
  }
}
