import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_service.dart';

class ConfiguracoesScreen extends StatefulWidget {
  @override
  _ConfiguracoesScreenState createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  @override
  Widget build(BuildContext context) {
    final audioService = Provider.of<AudioService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: audioService.getVolume(),
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Volume: ${audioService.getVolume().toStringAsFixed(1)}',
              onChanged: (value) async {
                await audioService.setVolume(value);
                setState(() {});
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await audioService.toggleMute();
                setState(() {});
              },
              child: Text(audioService.isMuted() ? 'Unmute' : 'Mute'),
            ),
          ],
        ),
      ),
    );
  }
}
