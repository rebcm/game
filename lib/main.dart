import 'package:flutter/material.dart';
import 'package:game/rendering_prototype/rendering_prototype.dart';

void main() {
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
      home: RenderingPrototype(),
    );
  }
}
