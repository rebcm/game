import 'package:rebcm/engine_3d/engine_3d.dart';

class Fisica {
  final Engine3D _engine3d;

  Fisica(this._engine3d);

  void aplicarFisica() {
    // Implement physics logic here
  }

  void atualizar() {
    // Implement physics update logic here
    aplicarFisica();
  }
}
