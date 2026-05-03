import 'package:flutter/material.dart';

class DicasIntegracao {
  static void mostrarDica(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  static void configurarDicas(BuildContext context) {
    // Configuração das dicas de UI
    // Deve ser chamado no início da jornada do usuário
  }
}
