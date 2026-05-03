import 'package:flutter/foundation.dart';

class TelemetriaDicas with ChangeNotifier {
  int _dicasExibidas = 0;
  int _dicasIgnoradas = 0;

  int get dicasExibidas => _dicasExibidas;
  int get dicasIgnoradas => _dicasIgnoradas;

  void dicaExibida() {
    _dicasExibidas++;
    notifyListeners();
  }

  void dicaIgnorada() {
    _dicasIgnoradas++;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'dicasExibidas': _dicasExibidas,
      'dicasIgnoradas': _dicasIgnoradas,
    };
  }
}
