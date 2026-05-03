import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/config/input_config.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inputConfig = Provider.of<InputConfig>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Deadzone Threshold: ${inputConfig.deadzoneThreshold}'),
            Slider(
              value: inputConfig.deadzoneThreshold,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: inputConfig.deadzoneThreshold.toString(),
              onChanged: (value) {
                inputConfig.setDeadzoneThreshold(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
