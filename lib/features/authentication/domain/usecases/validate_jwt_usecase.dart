import 'package:passdriver/features/authentication/data/repositories/authentication_repository.dart';

class ValidateJwtUsecase {
  final AuthenticationRepository _repository;

  ValidateJwtUsecase(this._repository);

  Future<bool> call() async {
    return await _repository.isTokenValid();
  }
}
