import 'package:flutter/material.dart';
import 'package:game/chunk/chunk_manager.dart';

void main() {
  final chunkManager = ChunkManager(100); // Example capacity
  runApp(MyApp(chunkManager: chunkManager));
}

class MyApp extends StatelessWidget {
  final ChunkManager chunkManager;

  const MyApp({Key? key, required this.chunkManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Creative Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rebeca\'s Creative Game'),
      ),
      body: const Center(
        child: Text('Game Content'),
      ),
    );
  }
}
