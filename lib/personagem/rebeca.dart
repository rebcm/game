import 'package:flutter/material.dart';

class Rebeca extends StatefulWidget {
  @override
  _RebecaState createState() => _RebecaState();
}

class _RebecaState extends State<Rebeca> with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _velocidade = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  void mudarVelocidade(double novaVelocidade) {
    _velocidade = novaVelocidade;
    _animationController.animateTo(_velocidade / 100);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_velocidade, 0),
          child: child,
        );
      },
      child: Container(),
    );
  }
}
