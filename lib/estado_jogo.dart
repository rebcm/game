import 'package:flutter/material.dart';

class EstadoJogo extends StatefulWidget {
  @override
  _EstadoJogoState createState() => _EstadoJogoState();
}

class _EstadoJogoState extends State<EstadoJogo> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado Jogo'),
      ),
      body: Center(
        child: Text('Estado Jogo'),
      ),
    );
  }
}
