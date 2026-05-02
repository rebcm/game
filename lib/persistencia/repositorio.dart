import 'package:rebcm/persistencia/datasource.dart';

class Repositorio {
  final Datasource _datasource;

  Repositorio(this._datasource);

  Future<void> inserirDados(String dados) async {
    try {
      await _datasource.salvarD1(dados);
      await _datasource.salvarR2(dados);
    } catch (e) {
      await _datasource.limparD1();
      rethrow;
    }
  }
}
