import 'package:flutter/material.dart';
import 'package:game/utils/bloco_referencia.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bloco Referência'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: BlocoReferencia.imprimirBlocos,
            child: Text('Imprimir Blocos'),
          ),
        ),
      ),
    );
  }
}
