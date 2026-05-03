import 'package:rebcm/data/repository/name_repository.dart';

class ValidateNameUsecase {
  final NameRepository _repository;

  ValidateNameUsecase(this._repository);

  Future<bool> call(String name) async {
    return !await _repository.checkName(name);
  }
}
