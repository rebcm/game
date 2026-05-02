import 'package:flutter/material.dart';
import 'package:rebcm/utils/fps_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Voxel World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      // Use FPSCalculator here
      final fps = FPSCalculator.calculateFPS();
      print('Current FPS: $fps');
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Rebeca\'s Voxel World'),
      ),
    );
  }
}
import 'package:rebcm/widgets/optimized_image.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OptimizedImage(
      imageUrl: 'https://example.com/image.jpg',
      cacheWidth: 100,
      cacheHeight: 100,
    );
  }
}
