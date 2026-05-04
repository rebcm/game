import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class SerializationErrorHandler {
  static final Logger _logger = Logger('SerializationErrorHandler');

  void handleSerializationError(dynamic error) {
    _logger.severe('Erro de serialização', error);
    // Implementar lógica de recuperação de erros de serialização
  }

  void notifyUser(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

