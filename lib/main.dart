import 'package:flutter/material.dart';
import 'package:game/chunk_manager/chunk_lock_manager.dart';
import 'package:game/chunk_manager/queue/chunk_write_queue.dart';

void main() {
  final ChunkLockManager lockManager = ChunkLockManager();
  final ChunkWriteQueue writeQueue = ChunkWriteQueue(lockManager);

  // Example usage
  writeQueue.addWriteRequest(ChunkWriteRequest(chunkId: 'chunk1', data: 'some data'));

  runApp(MyApp(writeQueue: writeQueue));
}

class MyApp extends StatelessWidget {
  final ChunkWriteQueue writeQueue;

  const MyApp({Key? key, required this.writeQueue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chunk Write Queue Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              writeQueue.addWriteRequest(ChunkWriteRequest(chunkId: 'chunk1', data: 'new data'));
            },
            child: Text('Write to Chunk'),
          ),
        ),
      ),
    );
  }
}
