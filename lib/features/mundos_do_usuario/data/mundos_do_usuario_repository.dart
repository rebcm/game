import 'package:passdriver/features/mundos_do_usuario/data/mundos_do_usuario_data_source.dart';

class MundosDoUsuarioRepository {
  final MundosDoUsuarioDataSource _dataSource;

  MundosDoUsuarioRepository(this._dataSource);

  Future<String> getMundosDoUsuario() async {
    return await _dataSource.getMundosDoUsuario();
  }
}
