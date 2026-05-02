import 'package:flutter/material.dart';
import 'package:rebcm/services/audio_manager/audio_manager_singleton.dart';

class AppLifecycleManager with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      AudioManagerSingleton.dispose();
    }
  }
}
