import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Voxel Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rebeca Voxel Game'),
        ),
        body: Center(
          child: ElevatedButton(
            key: Key('upload_binarios'),
            onPressed: () {
              // Simula o upload de binários e dispara a política de retenção
              print('Política de retenção disparada');
            },
            child: Text('Upload Binários'),
          ),
        ),
      ),
    );
  }
}
