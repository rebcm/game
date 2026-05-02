import 'package:flutter/material.dart';
import 'package:rebcm/widgets/animated/optimized_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
      home: const OptimizedAnimation(),
    );
  }
}
