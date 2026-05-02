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
            subtitle: Text('3.16.5 ou superior / 3.2.3 ou superior'),
          ),
          ListTile(
            title: Text('SDKs Android/iOS'),
            subtitle: Text('API level 33 ou superior / 17.0 ou superior'),
          ),
          ListTile(
            title: Text('Variáveis de Ambiente'),
            subtitle: Text('PASSDRIVER_API_KEY, PASSDRIVER_ENV'),
          ),
          ListTile(
            title: Text('Chaves de API Necessárias'),
            subtitle: Text('OpenStreetMap, backend da PassDriver'),
          ),
          ListTile(
            title: Text('Passos de Validação do Build'),
            subtitle: Text('1. Verificar Flutter e Dart\n2. Executar flutter pub get\n3. Verificar variáveis de ambiente\n4. Executar flutter run'),
          ),
        ],
      ),
    );
  }
}

