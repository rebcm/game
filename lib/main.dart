import 'package:flutter/material.dart';
import 'package:game/services/dicas_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      home: Scaffold(
        body: FutureBuilder(
          future: DicasService().verificarAprovacaoTecnica(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data as bool) {
                return Text('Dicas aprovadas tecnicamente');
              } else {
                return Text('Erro: Dicas não aprovadas tecnicamente');
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
