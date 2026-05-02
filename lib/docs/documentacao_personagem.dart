import 'package:flutter/material.dart';
import 'package:rebcm/constantes/constantes.dart';

class DocumentacaoPersonagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentação da Personagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(Constantes.descricaoPersonagem),
      ),
    );
  }
}
