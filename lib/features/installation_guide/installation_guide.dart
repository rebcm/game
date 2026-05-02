import 'package:flutter/material.dart';

class InstallationGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guia de Instalação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('### Pré-requisitos para Instalação', style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text('- Flutter SDK versão 3.10.0 ou superior'),
            Text('- Dart SDK versão 3.0.0 ou superior (incluso no Flutter SDK)'),
            Text('- Android Studio ou Xcode para desenvolvimento mobile'),
            Text('- CocoaPods para gerenciamento de dependências iOS'),
          ],
        ),
      ),
    );
  }
}
