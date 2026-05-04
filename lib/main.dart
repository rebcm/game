import 'package:flutter/material.dart';
import 'package:game/config/environment_config.dart';

void main() {
  EnvironmentConfig.init(environment: Environment.staging);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rebeca Game'),
      ),
      body: Center(
        child: Text('Environment: ${EnvironmentConfig.environment}'),
      ),
    );
  }
}
