import 'package:flutter/material.dart';
import 'package:game/widgets/dicas/dica_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: DicaWrapper(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            (context.findAncestorWidgetOfExactType<DicaWrapper>() as DicaWrapper).mostrarDica('Bem-vindo ao Rebeca Game!');
          },
          child: Text('Mostrar Dica'),
        ),
      ),
    );
  }
}
