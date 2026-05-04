import 'package:flutter/material.dart';
import 'package:game/ui/widgets/settings/volume_slider.dart';
import 'package:game/ui/widgets/settings/mute_toggle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Volume'),
            const VolumeSlider(),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Mute'),
                const MuteToggle(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
