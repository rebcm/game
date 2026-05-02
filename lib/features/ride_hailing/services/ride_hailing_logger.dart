import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class RideHailingLogger {
  final Logger _logger;

  RideHailingLogger(this._logger);

  void logAuthenticationError(String message) {
    _logger.e('Erro de autenticação: $message');
  }

  void logTimeoutError(String message) {
    _logger.e('Timeout: $message');
  }

  void logPayloadLimitError(String message) {
    _logger.e('Limite de payload excedido: $message');
  }
}
