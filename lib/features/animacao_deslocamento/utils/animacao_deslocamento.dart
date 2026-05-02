import 'package:flutter/material.dart';
import 'package:passdriver/features/animacao_deslocamento/providers/matriz_velocidade_provider.dart';

class AnimacaoDeslocamento extends StatefulWidget {
  @override
  void dispose() { 
    // Dispose AnimationControllers here
    super.dispose();
  }
  @override
  _AnimacaoDeslocamentoState createState() => _AnimacaoDeslocamentoState();
}

class _AnimacaoDeslocamentoState extends State<AnimacaoDeslocamento> with TickerProviderStateMixin { with AnimationControllerDisposer {
  late AnimationController _animationController;
  double _velocidadeDeslocamento = 10.0; // exemplo

  @override
  void initState() {
    super.initState();
    final matrizVelocidadeProvider = MatrizVelocidadeProvider();
    matrizVelocidadeProvider.carregarMatrizVelocidade();
    final matrizVelocidade = matrizVelocidadeProvider.matrizVelocidade
        .firstWhere((element) => element.velocidadeDeslocamento == _velocidadeDeslocamento);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // implementar a lógica de animação aqui
    return Container();
  }
}
