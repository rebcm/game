import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class InstallationGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guia de Instalação'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Versão do Flutter/Dart: 3.16.5 ou superior'),
            Text('Android SDK: API nível 33 ou superior'),
            Text('iOS SDK: 17.0 ou superior'),
            Text('Variáveis de Ambiente: FLUTTER_ROOT e ANDROID_HOME'),
            Text('Chave da API do OpenStreetMap: ${ApiKeys.openStreetMapApiKey}'),
            ElevatedButton(
              onPressed: () {
                // TODO: Implementar lógica para verificar os pré-requisitos
              },
              child: Text('Verificar Pré-requisitos'),
            ),
            MapWidget(
              // Implementar mapa com flutter_map
            ),
          ],
        ),
      ),
    );
  }
}
