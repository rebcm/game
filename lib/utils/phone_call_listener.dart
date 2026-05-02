import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

class PhoneCallListener with WidgetsBindingObserver {
  final AudioHandler _audioHandler;

  PhoneCallListener(this._audioHandler) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioHandler.pause();
    } else if (state == AppLifecycleState.resumed) {
      _audioHandler.play();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
