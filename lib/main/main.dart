import 'package:flutter/material.dart';
import 'package:game/services/audio/audio_permission_service.dart';
import 'package:game/utils/android_version_check/android_version_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (AndroidVersionCheck().isAndroid13OrHigher()) {
    final audioPermissionService = AudioPermissionService();
    final hasPermission = await audioPermissionService.requestAudioPermission();
    if (!hasPermission) {
      // Handle permission denied
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: Text('Rebeca Game'),
      ),
    );
  }
}
