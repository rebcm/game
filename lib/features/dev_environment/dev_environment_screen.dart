import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/providers/dev_provider.dart';

class DevEnvironment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devProvider = Provider.of<DevProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambiente de Desenvolvimento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Instruções de Instalação:'),
            SizedBox(height: 20),
            Text('1. Instale o Flutter e o Dart no seu computador.'),
            SizedBox(height: 10),
            Text('2. Clone o repositório do PassDriver.'),
            SizedBox(height: 10),
            Text('3. Execute o comando flutter pub get no terminal.'),
            SizedBox(height: 10),
            Text('4. Execute o comando flutter run no terminal.'),
          ],
        ),
      ),
    );
  }
}
