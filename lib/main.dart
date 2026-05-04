import 'package:flutter/material.dart';
import 'package:game/config/environment_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: EnvironmentConfig.isPreview ? PreviewPage() : GamePage(),
    );
  }
}

class PreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Environment'),
      ),
      body: Center(
        child: Text('Preview Environment'),
      ),
    );
  }
}

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // existing game page implementation
  }
}
