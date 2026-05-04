import 'package:flutter/material.dart';
import 'package:game/config/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construção Criativa da Rebeca',
      home: const MyHomePage(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Construção Criativa da Rebeca'),
      ),
      body: const Center(
        child: Text('Construção Criativa da Rebeca'),
      ),
    );
  }
}
