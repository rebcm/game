import 'package:dartz/dartz.dart';
import 'package:passdriver/features/auth/data/auth_repository.dart';

class AuthUsecase {
  final AuthRepository _repository;

  AuthUsecase(this._repository);

  Future<Either<String, String>> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}
