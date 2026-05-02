import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<Either<Exception, String>> login(String email, String password) async {
    final response = await _client.post(
      Uri.parse('/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: '{"email": "", "password": ""}',
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(Exception('Falha ao realizar login'));
    }
  }
}
