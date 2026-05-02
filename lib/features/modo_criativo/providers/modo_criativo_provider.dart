import 'package:flutter/material.dart';
class ModoCriativoProvider with ChangeNotifier {
  bool _voarHabilitado = true;
  bool get voarHabilitado => _voarHabilitado;
  void toggleVoar() {
    _voarHabilitado = !_voarHabilitado;
    notifyListeners();
  }
}
