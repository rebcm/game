import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/utils/memory/memory_profiler.dart';

class MemoryAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoryProfiler(),
      child: Consumer<MemoryProfiler>(
        builder: (context, memoryProfiler, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Memory Analysis'),
            ),
            body: Center(
              child: Column(
                mainChildren: [
                  ElevatedButton(
                    onPressed: memoryProfiler.captureMemorySnapshot,
                    child: Text('Capture Memory Snapshot'),
                  ),
                  ElevatedButton(
                    onPressed: memoryProfiler.clearMemorySnapshots,
                    child: Text('Clear Memory Snapshots'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: memoryProfiler.memorySnapshots.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Snapshot ${index + 1}'),
                          subtitle: Text('${memoryProfiler.memorySnapshots[index]} ms'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
