import 'package:game/personagem/maquina_estado/maquina_estado_rebeca.dart';

class Rebeca {
  final MaquinaEstadoRebeca _maquinaEstado;

  Rebeca() : _maquinaEstado = MaquinaEstadoRebeca();

  void atualizar() {
    _maquinaEstado.atualizar();
  }
}
