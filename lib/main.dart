import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio/audio_pool.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPool()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPool = Provider.of<AudioPool>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await audioPool.play('assets/audio/optimized/break_block.mp3');
          },
          child: Text('Play Sound'),
        ),
      ),
    );
  }
}
