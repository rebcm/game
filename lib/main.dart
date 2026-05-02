import 'package:flutter/material.dart';
import 'package:passdriver/features/animation_speed_control/screens/speed_matrix_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      home: SpeedMatrixScreen(),
    );
  }
}
