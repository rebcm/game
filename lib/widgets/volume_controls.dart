import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/providers/volume_provider.dart';

class VolumeControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final volumeProvider = Provider.of<VolumeProvider>(context);
    return Row(
      children: [
        Slider(
          value: volumeProvider.volume,
          onChanged: (value) async {
            await volumeProvider.setVolume(value);
          },
        ),
        IconButton(
          icon: Icon(volumeProvider.mute ? Icons.volume_off : Icons.volume_up),
          onPressed: () async {
            await volumeProvider.toggleMute();
          },
        ),
      ],
    );
  }
}
