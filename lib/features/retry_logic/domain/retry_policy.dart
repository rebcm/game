import 'package:flutter/foundation.dart';

class RetryPolicy with ChangeNotifier {
  int _maxAttempts = 5;
  int _initialDelay = 500; // milliseconds
  double _backoffFactor = 2.0;

  int get maxAttempts => _maxAttempts;

  Future<void> retry(Future<void> Function() operation) async {
    int attempts = 0;
    int delay = _initialDelay;

    while (attempts < _maxAttempts) {
      try {
        await operation();
        return;
      } catch (e) {
        attempts++;
        await Future.delayed(Duration(milliseconds: delay));
        delay = (delay * _backoffFactor).round();
      }
    }

    throw Exception('Falha ao realizar operação após  tentativas');
  }
}
