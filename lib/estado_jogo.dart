import 'dart:async';
import 'package:flutter/material.dart';

class EstadoJogo extends StatefulWidget {
  @override
  _EstadoJogoState createState() => _EstadoJogoState();
}

class _EstadoJogoState extends State<EstadoJogo> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
