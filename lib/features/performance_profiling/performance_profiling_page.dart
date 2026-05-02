import 'package:flutter/material.dart';
import 'package:devtools_flutter/devtools_flutter.dart';

class PerformanceProfilingPage extends StatefulWidget {
  @override
  _PerformanceProfilingPageState createState() => _PerformanceProfilingPageState();
}

class _PerformanceProfilingPageState extends State<PerformanceProfilingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance Profiling'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            DevToolsFlutter.togglePerformanceOverlay();
          },
          child: Text('Toggle Performance Overlay'),
        ),
      ),
    );
  }
}
