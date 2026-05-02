import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_codec.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioCodec.configureAudioCodec();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s World'),
      ),
      body: Center(
        child: Text('Hello, Rebeca!'),
      ),
    );
  }
}
