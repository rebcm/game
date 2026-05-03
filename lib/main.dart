import 'package:flutter/material.dart';
import 'package:game/widgets/chunk_widget.dart';

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
  String chunkId = '1';

  void _updateChunk() {
    setState(() {
      chunkId = '2';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ChunkWidget(chunkId: chunkId),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateChunk,
        tooltip: 'Update Chunk',
        child: Icon(Icons.update),
      ),
    );
  }
}
