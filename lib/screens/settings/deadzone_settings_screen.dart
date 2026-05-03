import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/config/deadzone_config.dart';

class DeadzoneSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deadzone Settings'),
      ),
      body: Consumer<DeadzoneConfig>(
        builder: (context, deadzoneConfig, child) {
          return Column(
            children: [
              Slider(
                value: deadzoneConfig.deadzoneThreshold,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: deadzoneConfig.deadzoneThreshold.toString(),
                onChanged: (value) {
                  deadzoneConfig.setDeadzoneThreshold(value);
                },
              ),
              Text('Deadzone Threshold: ${deadzoneConfig.deadzoneThreshold}'),
            ],
          );
        },
      ),
    );
  }
}
