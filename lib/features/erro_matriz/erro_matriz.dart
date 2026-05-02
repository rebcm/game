library erro_matriz;
import 'package:flutter/material.dart';
class ErroMatriz with ChangeNotifier {
  String? _logErro;
  String? get logErro => _logErro;
  void setLogErro(String? logErro) {
    _logErro = logErro;
    notifyListeners();
  }
}
