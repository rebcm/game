import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class UploadTestScreen extends StatefulWidget {
  @override
  _UploadTestScreenState createState() => _UploadTestScreenState();
}

class _UploadTestScreenState extends State<UploadTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste de Upload'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Implementar lógica de teste de upload aqui
          },
          child: Text('Iniciar Teste'),
        ),
      ),
    );
  }
}
