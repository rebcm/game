import 'package:passdriver/features/mundos_do_usuario/data/mundos_do_usuario_repository.dart';

class MundosDoUsuarioUseCase {
  final MundosDoUsuarioRepository _repository;

  MundosDoUsuarioUseCase(this._repository);

  Future<String> getMundosDoUsuario() async {
    return await _repository.getMundosDoUsuario();
  }
}
