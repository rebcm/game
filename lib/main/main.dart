import 'package:flutter/material.dart';
import 'package:game/services/secrets_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecretsService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s Game'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
