import 'package:flutter/material.dart';

class ChecklistPreRequisitos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist de Pré-requisitos'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Versão do Flutter/Dart'),
            subtitle: Text('3.10.0 / 3.0.0'),
          ),
          ListTile(
            title: Text('SDKs Android/iOS'),
            subtitle: Text('Android 21 / iOS 13.0'),
          ),
          ListTile(
            title: Text('Variáveis de Ambiente'),
            subtitle: Text('PASSDRIVER_API_KEY, MAPS_API_KEY'),
          ),
          ListTile(
            title: Text('Chaves de API Necessárias'),
            subtitle: Text('PassDriver, OpenStreetMap'),
          ),
          ListTile(
            title: Text('Passos de Validação do Build'),
            subtitle: Text('1. Verifique Flutter e Dart\n2. Configure variáveis de ambiente\n3. Execute flutter pub get\n4. Verifique SDKs\n5. Execute flutter run'),
          ),
        ],
      ),
    );
  }
}
