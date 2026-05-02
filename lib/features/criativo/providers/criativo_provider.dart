import 'package:flutter/material.dart';

class CriativoProvider with ChangeNotifier {
  bool _voar = false;
  bool _pular = false;

  bool get voar => _voar;
  bool get pular => _pular;

  void toggleVoar() {
    _voar = !_voar;
    notifyListeners();
  }

  void togglePular() {
    _pular = !_pular;
    notifyListeners();
  }
}
