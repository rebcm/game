import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/criativo/providers/criativo_provider.dart';

class CriativoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final criativoProvider = context.watch<CriativoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Criativo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: criativoProvider.toggleVoar,
              child: Text(criativoProvider.voar ? 'Parar de Voar' : 'Voar'),
            ),
            ElevatedButton(
              onPressed: criativoProvider.togglePular,
              child: Text(criativoProvider.pular ? 'Parar de Pular' : 'Pular'),
            ),
          ],
        ),
      ),
    );
  }
}
