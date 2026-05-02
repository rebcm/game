import 'package:flutter/material.dart';

class EstadoJogo extends StatefulWidget {
  @override
  EstadoJogoState createState() => EstadoJogoState();
}

class EstadoJogoState extends State<EstadoJogo> with TickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {});
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
