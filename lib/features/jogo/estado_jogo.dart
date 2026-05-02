import 'dart:async';
import 'package:flutter/material.dart';

class EstadoJogo with ChangeNotifier {
  Timer? _timer;

  void iniciar() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
