import 'package:flutter/material.dart';
import 'package:game/utils/env_validator.dart';

void main() async {
  try {
    await EnvValidator.validateEnv();
    runApp(MyApp());
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Existing code here...
  }
}
