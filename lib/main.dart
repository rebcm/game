import 'package:flutter/material.dart';
import 'package:game/utils/env_validator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await EnvValidator.validateEnv();
    runApp(const MyApp());
  } catch (e) {
    print('Error: $e');
    exit(1); // or handle error as per your requirement
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Your existing code here
  }
}
