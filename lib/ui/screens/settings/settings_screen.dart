import 'package:flutter/material.dart';
import 'package:game/ui/widgets/settings/volume_slider.dart';
import 'package:game/ui/widgets/settings/mute_toggle.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Volume'),
            trailing: VolumeSlider(),
          ),
          ListTile(
            title: Text('Mute'),
            trailing: MuteToggle(),
          ),
        ],
      ),
    );
  }
}
