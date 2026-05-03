import 'package:flutter/foundation.dart';

class TelemetriaDicas {
  void dicaVisualizada(String idDica) {
    // Implementar lógica para registrar visualização de dica
    if (kDebugMode) {
      print('Dica visualizada: $idDica');
    }
  }

  void dicaInteragida(String idDica) {
    // Implementar lógica para registrar interação com dica
    if (kDebugMode) {
      print('Dica interagida: $idDica');
    }
  }
}
