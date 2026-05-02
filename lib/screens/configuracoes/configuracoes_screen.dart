import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/services/audio/audio_service.dart';

class ConfiguracoesScreen extends StatefulWidget {
  @override
  _ConfiguracoesScreenState createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _volume = context.read<AudioServiceImpl>().getVolume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              value: _volume,
              onChanged: (value) async {
                await context.read<AudioServiceImpl>().setVolume(value);
                setState(() => _volume = value);
              },
              min: 0.0,
              max: 1.0,
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<AudioServiceImpl>().toggleMute();
                setState(() => _volume = context.read<AudioServiceImpl>().getVolume());
              },
              child: Text(_volume == 0 ? 'Desmutar' : 'Mutar'),
            ),
          ],
        ),
      ),
    );
  }
}
