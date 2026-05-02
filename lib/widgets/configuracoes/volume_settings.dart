import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/configuracoes/volume/volume_provider.dart';

class VolumeSettings extends StatelessWidget {
  const VolumeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volumeProvider = context.watch<VolumeProvider>();
    return Column(
      children: [
        Slider(
          value: volumeProvider.volumeConfig.volume,
          onChanged: (value) {
            volumeProvider.updateVolumeConfig(
              volumeProvider.volumeConfig.copyWith(volume: value),
            );
          },
        ),
        SwitchListTile(
          title: const Text('Mute'),
          value: volumeProvider.volumeConfig.isMuted,
          onChanged: (value) {
            volumeProvider.updateVolumeConfig(
              volumeProvider.volumeConfig.copyWith(isMuted: value),
            );
          },
        ),
      ],
    );
  }
}
