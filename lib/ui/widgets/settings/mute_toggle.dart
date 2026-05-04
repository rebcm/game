import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MuteToggle extends StatefulWidget {
  const MuteToggle({super.key});

  @override
  State<MuteToggle> createState() => _MuteToggleState();
}

class _MuteToggleState extends State<MuteToggle> {
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isMuted,
      onChanged: (bool value) async {
        setState(() {
          _isMuted = value;
        });
        await AudioPlayer.global.setVolume(_isMuted ? 0.0 : 1.0);
      },
    );
  }
}
