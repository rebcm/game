import 'package:rebcm/engine_3d/engine_3d.dart';

class Fisica {
  late Engine3D _engine3D;

  Fisica(this._engine3D);

  void atualizar() {
    // Implementação da atualização da física
    _engine3D.update();
  }

  void aplicarGravidade() {
    // Implementação da aplicação da gravidade
  }
}
