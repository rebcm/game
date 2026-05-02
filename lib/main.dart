import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rebeca\'s Voxel World'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Simula a validação de um artefato íntegro
                },
                child: Text('Validar Artefato'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Simula a corrupção do artefato
                },
                child: Text('Corromper Artefato'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
