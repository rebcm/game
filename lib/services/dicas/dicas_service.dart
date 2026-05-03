import 'package:flutter/material.dart';

class DicasService {
  static DicasService? _instance;

  factory DicasService() {
    _instance ??= DicasService._();
    return _instance!;
  }

  DicasService._();

  void mostrarDica(BuildContext context, String mensagem) {
    // Implementar lógica para exibir dica
    // Pode ser um modal, tooltip, etc.
    // Deve ser configurável
  }
}
