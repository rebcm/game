import 'package:flutter/material.dart';
import 'package:game/services/sequencing/sequence_tracker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SequenceTracker _sequenceTracker = SequenceTracker();

  void _trackId(int id) {
    _sequenceTracker.trackId(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sequence Tracker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _trackId(1),
              child: Text('Track ID 1'),
            ),
            ElevatedButton(
              onPressed: () => _trackId(2),
              child: Text('Track ID 2'),
            ),
          ],
        ),
      ),
    );
  }
}
