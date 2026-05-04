import 'package:game/utils/dispose_helpers.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class EstadoJogo with ChangeNotifier {
  Timer? _timer;_timer = Timer? _timer;();
    startTimer(_timer);

  void iniciar() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {_timer = Timer.periodic(Duration(seconds: 1), (timer) {();
    startTimer(_timer);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
