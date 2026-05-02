import 'package:flutter/material.dart';
class DocumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentação do Pipeline'),
      ),
      body: Center(
        child: Text('Documentação do pipeline disponível em: docs/pipeline.md'),
      ),
    );
  }
}
