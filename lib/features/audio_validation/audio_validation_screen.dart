import 'package:flutter/material.dart';
import 'package:passdriver/features/audio_validation/audio_validation.dart';

class AudioValidationScreen extends StatefulWidget {
  @override
  _AudioValidationScreenState createState() => _AudioValidationScreenState();
}

class _AudioValidationScreenState extends State<AudioValidationScreen> {
  String _result = '';

  void _validateFormat(String format) async {
    final isSupported = await validateAudioFormat(format);
    setState(() {
      _result = isSupported ? 'Suportado' : 'Não suportado';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validação de Formato de Áudio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _validateFormat('ogg'),
              child: Text('Validar OGG'),
            ),
            ElevatedButton(
              onPressed: () => _validateFormat('mp3'),
              child: Text('Validar MP3'),
            ),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
