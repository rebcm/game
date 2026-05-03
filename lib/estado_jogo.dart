import 'package:flutter/material.dart';

class EstadoJogo with ChangeNotifier {
  bool _mounted = true;

  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
