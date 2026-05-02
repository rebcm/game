import 'package:flutter/material.dart';

class InstallationChecklist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Versão do Flutter: 3.10.6 ou superior'),
          value: true, // TODO: implementar lógica para verificar a versão do Flutter
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('Dart SDK: 3.0.6 ou superior'),
          value: true, // TODO: implementar lógica para verificar a versão do Dart SDK
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('Configuração de Emulador: Android Studio ou Xcode'),
          value: true, // TODO: implementar lógica para verificar a configuração do emulador
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: Text('Variáveis de Ambiente: configuradas corretamente'),
          value: true, // TODO: implementar lógica para verificar as variáveis de ambiente
          onChanged: (value) {},
        ),
      ],
    );
  }
}
