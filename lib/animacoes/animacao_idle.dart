import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimacaoIdle extends StatelessWidget {
  const AnimacaoIdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animacoes/idle.json',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      repeat: true,
      animate: true,
    );
  }
}

