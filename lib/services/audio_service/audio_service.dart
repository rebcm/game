import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void shuffle() {
    // Implement shuffle logic
    notifyListeners();
  }

  void loop() {
    // Implement loop logic
    notifyListeners();
  }
}
