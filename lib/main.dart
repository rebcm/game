import 'package:flutter/material.dart';
import 'package:game/utils/debug_profiler.dart';
import 'package:game/widgets/debug_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DebugProfiler()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voxel Game',
      home: const MyHomePage(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const DebugOverlay(),
          ],
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voxel Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              Provider.of<DebugProfiler>(context, listen: false).toggle();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Voxel Game Content'),
      ),
    );
  }
}
