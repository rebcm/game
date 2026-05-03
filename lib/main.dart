import 'package:flutter/material.dart';
import 'package:game/utils/debug_logger.dart';
import 'package:game/widgets/debug_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DebugLogger()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final debugLogger = context.watch<DebugLogger>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Voxel Game'),
        actions: [
          IconButton(
            icon: Icon(debugLogger.isEnabled ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              debugLogger.toggle();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Voxel Game Content'),
      ),
    );
  }
}
