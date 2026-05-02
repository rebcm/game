import 'package:dartz/dartz.dart';
import 'package:passdriver/features/mundos_do_usuario/data/mundos_do_usuario_repository.dart';

class MundosDoUsuarioUsecase {
  final MundosDoUsuarioRepository _repository;

  MundosDoUsuarioUsecase(this._repository);

  Future<Either<Exception, List<MundosDoUsuario>>> call() async {
    return await _repository.getMundosDoUsuario();
  }
}
