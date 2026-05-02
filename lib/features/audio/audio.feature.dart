import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFeature {
  final AudioPlayer _audioPlayer;

  AudioFeature(this._audioPlayer);

  void playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url), isLocal: false);
  }

  void pauseAudio() async {
    await _audioPlayer.pause();
  }

  void stopAudio() async {
    await _audioPlayer.stop();
  }
}
