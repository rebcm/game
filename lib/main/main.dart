import 'package:flutter/material.dart';
import 'package:rebcm/main/audio_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioInitializer.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebcm Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Rebcm Game'),
      ),
    );
  }
}
