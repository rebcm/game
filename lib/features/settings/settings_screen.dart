import 'package:flutter/material.dart';
import 'package:game/features/settings/widgets/audio_settings_widget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AudioSettingsWidget(),
      ),
    );
  }
}
