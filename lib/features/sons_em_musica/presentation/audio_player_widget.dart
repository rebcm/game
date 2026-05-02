import 'package:flutter/material.dart';
import 'package:sons_em_musica/domain/audio_player.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer(SharedPreferences.getInstance());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.playMusica('music/dia_01.ogg');
          },
          child: Text('Play Música'),
        ),
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.stopMusica();
          },
          child: Text('Stop Música'),
        ),
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.playEfeito('sfx/colocar_bloco.ogg');
          },
          child: Text('Play Efeito'),
        ),
        Slider(
          value: _audioPlayer.getVolume(),
          onChanged: (value) async {
            await _audioPlayer.setVolume(value);
            await _audioPlayer.saveVolume();
          },
        ),
      ],
    );
  }
}
