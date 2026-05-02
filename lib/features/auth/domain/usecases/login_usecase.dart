import 'package:dartz/dartz.dart';
import 'package:passdriver/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<Either<Exception, String>> execute(String email, String password) async {
    return await _repository.login(email, password);
  }
}
