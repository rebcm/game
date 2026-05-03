import 'package:flutter/material.dart';
import 'package:game/utils/memoria_baseline.dart';

class EstadoJogo extends StatefulWidget {
  @override
  _EstadoJogoState createState() => _EstadoJogoState();
}

class _EstadoJogoState extends State<EstadoJogo> {
  @override
  void initState() {
    super.initState();
    MemoriaBaseline.registrarBaseline();
  }

  @override
  void dispose() {
    MemoriaBaseline.registrarBaselineAposDestruicao();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Implementar o widget do jogo
  }
}
