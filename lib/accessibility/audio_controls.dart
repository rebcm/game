import 'package:flutter/material.dart';
import 'package:rebcm/audio_manager.dart';

class AccessibleAudioControls extends StatefulWidget {
  @override
  _AccessibleAudioControlsState createState() => _AccessibleAudioControlsState();
}

class _AccessibleAudioControlsState extends State<AccessibleAudioControls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Semantics(
          label: 'Mute audio',
          child: IconButton(
            icon: Icon(Icons.volume_off),
            onPressed: () {
              AudioManager.instance.mute();
            },
          ),
        ),
        Semantics(
          label: 'Unmute audio',
          child: IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {
              AudioManager.instance.unmute();
            },
          ),
        ),
        Semantics(
          label: 'Volume slider',
          child: Slider(
            value: AudioManager.instance.volume,
            onChanged: (value) {
              AudioManager.instance.setVolume(value);
            },
          ),
        ),
      ],
    );
  }
}
