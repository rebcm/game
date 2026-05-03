import 'package:flutter/material.dart';
import 'package:game/services/secrets_validator.dart';

void main() async {
  await SecretsValidator.validateSecrets();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Game',
      home: // Your home widget here,
    );
  }
}
