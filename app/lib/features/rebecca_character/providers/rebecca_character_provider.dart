import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../audio/audio_provider.dart';

class RebeccaCharacterProvider with ChangeNotifier {
  // existing code...

  Future<void> jump() async {
    // existing jump logic...
    Provider.of<AudioProvider>(context, listen: false).playSfx('audio/sfx/pular.ogg');
  }
}
