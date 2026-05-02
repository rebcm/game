import 'package:flutter/foundation.dart';

enum EstadoPersonagem { parado, andando, pulando }

class MaquinaEstados with ChangeNotifier {
  EstadoPersonagem _estadoAtual = EstadoPersonagem.parado;

  EstadoPersonagem get estadoAtual => _estadoAtual;

  void mudarEstado(EstadoPersonagem novoEstado) {
    if (_estadoAtual != novoEstado) {
      _estadoAtual = novoEstado;
      notifyListeners();
    }
  }
}
