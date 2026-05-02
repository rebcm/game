import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final audioHandler = await initAudioService();
  runApp(MyApp(audioHandler));
}

class MyApp extends StatelessWidget {
  final AudioHandler _audioHandler;

  MyApp(this._audioHandler);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(_audioHandler),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final AudioHandler _audioHandler;

  MyHomePage(this._audioHandler);

  @override
  _MyHomePageState createState() => _MyHomePageState(_audioHandler);
}

class _MyHomePageState extends State<MyHomePage> {
  late AppLifecycleManager _appLifecycleManager;

  _MyHomePageState(AudioHandler audioHandler) : _audioHandler = audioHandler;

  final AudioHandler _audioHandler;

  @override
  void initState() {
    super.initState();
    _appLifecycleManager = AppLifecycleManager(_audioHandler);
  }

  @override
  void dispose() {
    _appLifecycleManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Rebeca Game'),
      ),
    );
  }
}
