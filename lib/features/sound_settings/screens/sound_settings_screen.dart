import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sound_settings_provider.dart';
import '../widgets/sound_settings_widget.dart';

class SoundSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SoundSettingsProvider(),
      child: SoundSettingsWidget(),
    );
  }
}
