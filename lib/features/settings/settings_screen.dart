import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/features/settings/providers/audio_settings_provider.dart';
import 'package:game/features/settings/widgets/audio_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioSettingsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: AudioSettings(),
      ),
    );
  }
}
