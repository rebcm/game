import 'package:flutter/material.dart';

class RetryPolicy with ChangeNotifier {
  bool shouldRetry(String errorType) {
    // Lógica para determinar se deve tentar novamente com base no tipo de erro
    return errorType == 'timeout' || errorType == 'connection_error';
  }

  void handleFailure(String errorType) {
    // Lógica para lidar com falha imediata
    if (!shouldRetry(errorType)) {
      // Notificar o usuário sobre a falha
      print('Falha ao realizar a operação: ');
    }
  }
}
