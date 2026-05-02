import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

class AppLifecycleManager with WidgetsBindingObserver {
  final AudioHandler _audioHandler;

  AppLifecycleManager(this._audioHandler) {
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
