import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
class AudioLoopTestWidget extends StatefulWidget {
  @override
  _AudioLoopTestWidgetState createState() => _AudioLoopTestWidgetState();
}
class _AudioLoopTestWidgetState extends State<AudioLoopTestWidget> {
  final _audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _audioPlayer.setAsset('assets/audio/test_audio.mp3');
    _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.play();
  }
  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: () async {
        await _audioPlayer.stop();
        await _audioPlayer.setAsset('assets/audio/compressed_test_audio.mp3');
        await _audioPlayer.setLoopMode(LoopMode.one);
        await _audioPlayer.play();
      },
      child: Text('Testar Áudio Comprimido'),
    );
}
