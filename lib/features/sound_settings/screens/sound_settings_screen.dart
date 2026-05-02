import Intl.message('package:flutter/material.dart');
import Intl.message('package:provider/provider.dart');
import Intl.message('../providers/sound_settings_provider.dart');
import Intl.message('../widgets/sound_settings_widget.dart');

class SoundSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SoundSettingsProvider(),
      child: SoundSettingsWidget(),
    );
  }
}
