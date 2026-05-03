import 'package:flutter/material.dart';
import 'package:game/ui/screens/help/help_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voxel Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
      routes: {
        '/help': (context) => const HelpScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voxel Game')),
      body: const Center(child: Text('Conteúdo do jogo')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/help'),
        tooltip: 'Ajuda',
        child: const Icon(Icons.help),
      ),
    );
  }
}
