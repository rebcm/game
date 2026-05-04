import 'package:flutter/material.dart';
import 'package:game/config/environment_config.dart';

void main() {
  EnvironmentConfig.init(environment: Environment.staging);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: Scaffold(
        body: Center(
          child: Text('Environment: ${EnvironmentConfig.environment}'),
        ),
      ),
    );
  }
}
