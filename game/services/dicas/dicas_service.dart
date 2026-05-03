import 'package:game/docs/dicas_template/template.dart';

class DicasService {
  List<Dica> _dicas = [];

  void adicionarDica(Dica dica) {
    if (dica.aprovacao) {
      _dicas.add(dica);
    } else {
      throw Exception("Dica não aprovada");
    }
  }

  List<Dica> getDicas() {
    return _dicas;
  }
}
