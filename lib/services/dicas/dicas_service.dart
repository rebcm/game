import 'package:flutter/material.dart';

class DicasService {
  static DicasService? _instance;

  factory DicasService() {
    _instance ??= DicasService._();
    return _instance!;
  }

  DicasService._();

  void mostrarDica(BuildContext context, String mensagem) {
    // Implementação da lógica de exibição de dicas
    // Pode ser um modal, tooltip, etc.
    // Deve ser configurável para evitar hardcode
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }
}
