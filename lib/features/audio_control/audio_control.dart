import 'package:flutter/material.dart';
import 'screens/audio_control_screen.dart';

void addAudioControlRoute(RouteSettings settings, Route<dynamic>? route) {
  if (settings.name == '/audio_control') {
    return MaterialPageRoute(builder: (_) => AudioControlScreen());
  }
  return route;
}
