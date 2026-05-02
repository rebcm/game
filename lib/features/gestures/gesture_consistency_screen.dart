import 'package:flutter/material.dart';
import 'package:passdriver/features/gestures/gesture_validator.dart';

class GestureConsistencyScreen extends StatefulWidget {
  @override
  _GestureConsistencyScreenState createState() => _GestureConsistencyScreenState();
}

class _GestureConsistencyScreenState extends State<GestureConsistencyScreen> {
  final _gestureValidator = GestureValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consistência de Gestos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_gestureValidator.validateGesture('LongPress', 'LongPress') ? 'Gestos consistentes' : 'Gestos inconsistentes'),
          ],
        ),
      ),
    );
  }
}
