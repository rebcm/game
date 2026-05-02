import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/utils/traducao.dart';

class Jogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final traducao = context.watch<TraducaoService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(traducao.traduzir('titulo')),
      ),
      body: Center(
        child: Text(traducao.traduzir('titulo')),
      ),
    );
  }
}
