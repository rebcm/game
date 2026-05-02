import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/utils/memory/memory_profiler.dart';

class MemoryDebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Debug'),
      ),
      body: Consumer<MemoryProfiler>(
        builder: (context, memoryProfiler, child) {
          return ListView.builder(
            itemCount: memoryProfiler.memorySnapshots.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Snapshot ${index + 1}'),
                subtitle: Text('Timestamp: ${memoryProfiler.memorySnapshots[index]}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MemoryProfiler>(context, listen: false).captureMemorySnapshot();
        },
        tooltip: 'Capture Memory Snapshot',
        child: Icon(Icons.camera),
      ),
    );
  }
}
