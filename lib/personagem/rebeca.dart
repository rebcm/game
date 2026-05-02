import 'package:rebcm/personagem/estado_rebeca.dart';

class Rebeca {
  final RebecaState _state;

  Rebeca(this._state);

  void atualizar(bool movimentando) {
    _state.atualizarEstado(movimentando);
  }

  EstadoRebeca get estado => _state.estado;
}
