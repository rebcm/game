import 'package:flutter/material.dart';
import 'package:game/utils/debug_logger.dart';

class ChunkWidget extends StatefulWidget {
  final String chunkId;

  const ChunkWidget({Key? key, required this.chunkId}) : super(key: key);

  @override
  State<ChunkWidget> createState() => _ChunkWidgetState();
}

class _ChunkWidgetState extends State<ChunkWidget> {
  @override
  Widget build(BuildContext context) {
    DebugLogger.log('Building ChunkWidget ${widget.chunkId}');
    return Container(
      child: Text('Chunk ${widget.chunkId}'),
    );
  }
}
