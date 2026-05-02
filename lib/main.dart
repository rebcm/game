import 'package:flutter/material.dart';
import 'package:performance_profiling/performance_profiling_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassDriver',
      home: PerformanceProfilingPage(),
    );
  }
}
