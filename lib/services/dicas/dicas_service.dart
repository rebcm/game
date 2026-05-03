import 'package:flutter/material.dart';

class DicasService {
  static DicasService? _instance;

  factory DicasService() => _instance ??= DicasService._();

  DicasService._();

  void mostrarDica(BuildContext context, String mensagem) {
    // Implementar lógica para exibir dicas
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagem)));
  }
}
