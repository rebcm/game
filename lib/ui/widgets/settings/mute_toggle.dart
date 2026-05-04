import 'package:flutter/material.dart';

class MuteToggle extends StatefulWidget {
  @override
  _MuteToggleState createState() => _MuteToggleState();
}

class _MuteToggleState extends State<MuteToggle> {
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isMuted,
      onChanged: (bool value) {
        setState(() {
          _isMuted = value;
        });
      },
    );
  }
}
