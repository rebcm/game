import 'package:flutter/material.dart';
import 'package:game/personagem/animacao_rebeca.dart';

class Rebeca extends StatefulWidget {
  @override
  _RebecaState createState() => _RebecaState();
}

class _RebecaState extends State<Rebeca> with TickerProviderStateMixin {
  late AnimacaoRebeca _animacao;

  @override
  void initState() {
    super.initState();
    _animacao = AnimacaoRebeca(this);
  }

  @override
  void dispose() {
    _animacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animacao,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animacao.anguloBracos,
          child: child,
        );
      },
      child: // Rebeca character rendering code here
    );
  }
}
