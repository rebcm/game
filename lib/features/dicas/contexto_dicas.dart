import 'package:flutter/material.dart';

class ContextoDicas with ChangeNotifier {
  bool _isFirstTime = true;

  bool get isFirstTime => _isFirstTime;

  void primeiraConstrucao() {
    _isFirstTime = false;
    notifyListeners();
  }

  void mostrarDicaToolTip(BuildContext context, String mensagem) {
    // Implementação para mostrar Tooltip
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void mostrarDicaModal(BuildContext context, String titulo, String mensagem) {
    // Implementação para mostrar Modal
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
