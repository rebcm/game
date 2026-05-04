import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateManagement with ChangeNotifier {
  // Implementação do gerenciamento de estado
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

