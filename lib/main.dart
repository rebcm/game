import 'package:flutter/material.dart';
import 'package:game/utils/resolution_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Game'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (ResolutionConstants.supportedResolutions.contains(constraints.maxWidth)) {
              return Text('Dicas'); // Simplified for demonstration
            } else {
              return Text('Unsupported resolution');
            }
          },
        ),
      ),
    );
  }
}
