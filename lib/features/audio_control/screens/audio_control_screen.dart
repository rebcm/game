import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_control_provider.dart';
import '../widgets/volume_slider.dart';

class AudioControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioControlProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Controle de Áudio'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              VolumeSlider(),
              SizedBox(height: 16),
              Consumer<AudioControlProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: provider.toggleMute,
                    child: Text(provider.isMuted ? 'Desmutar' : 'Mutar'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
