import 'package:flutter/material.dart';
import 'package:rebcm/main/app_lifecycle_manager.dart';
import 'package:rebcm/services/audio_manager/audio_manager_singleton.dart';

void main() {
  WidgetsBinding.instance.addObserver(AppLifecycleManager());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AudioManagerSingleton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AudioManagerSingleton.instance.play('assets/audio/optimized/sfx/button_click.mp3');
          },
          child: Text('Play Sound'),
        ),
      ),
    );
  }
}
