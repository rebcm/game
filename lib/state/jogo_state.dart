import 'dart:async';
import 'package:flutter/material.dart';

class JogoState with ChangeNotifier {
  Timer? _timer;

  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Some periodic task
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
