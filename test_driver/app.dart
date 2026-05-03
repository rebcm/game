import 'package:flutter/material.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  app.main();
}

class GainControl extends StatefulWidget {
  @override
  _GainControlState createState() => _GainControlState();
}

class _GainControlState extends State<GainControl> {
  double _gain = 0.0;

  void _increaseGain() {
    setState(() {
      _gain += 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Gain Control'),
        Text('Current Gain: $_gain', key: Key('current_volume')),
        ElevatedButton(
          onPressed: _increaseGain,
          child: Text('Increase Gain'),
          key: Key('increase_gain'),
        ),
      ],
    );
  }
}
