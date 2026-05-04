import "package:game/config/env_config.dart";
import 'package:flutter/material.dart';
import 'package:game/rendering_prototype/renderers/basic_model_renderer.dart';

void main() {
  EnvConfig.loadEnv();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BasicModelRenderer(),
    );
  }
}
