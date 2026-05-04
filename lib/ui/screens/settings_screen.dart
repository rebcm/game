import 'package:flutter/material.dart';
import 'package:game/ui/settings/volume_control.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: VolumeControl(),
      ),
    );
  }
}
