import 'package:flutter/material.dart';
import 'package:rebcm/game/widgets/three_d_scene/three_d_scene_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: ThreeDSceneWrapper(),
    );
  }
}
