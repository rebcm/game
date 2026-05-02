import 'package:flutter/material.dart';
import 'package:rebcm/services/auth/secret_validator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  final secret = dotenv.env['SECRET_KEY'];
  if (!SecretValidator.isValid(secret)) {
    throw Exception('Invalid secret key');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: Scaffold(
        body: Center(
          child: Text('Rebeca\'s World'),
        ),
      ),
    );
  }
}
