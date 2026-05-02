import 'package:flutter/material.dart';
import 'package:passdriver/features/r2/r2_constants.dart';

class R2ChunkVersioningScreen extends StatefulWidget {
  @override
  _R2ChunkVersioningScreenState createState() => _R2ChunkVersioningScreenState();
}

class _R2ChunkVersioningScreenState extends State<R2ChunkVersioningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Versionamento de Chunks no R2'),
      ),
      body: Center(
        child: Text('${R2_CHUNK_PREFIX}nome-do-chunk${R2_CHUNK_VERSION_SEPARATOR}versao'),
      ),
    );
  }
}
