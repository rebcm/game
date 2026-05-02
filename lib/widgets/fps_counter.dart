import 'package:flutter/material.dart';
import 'package:rebcm/utils/performance_monitor.dart';

class FPSCounter extends StatefulWidget {
  @override
  _FPSCounterState createState() => _FPSCounterState();
}

class _FPSCounterState extends State<FPSCounter> {
  final PerformanceMonitor _performanceMonitor;

  _FPSCounterState({required PerformanceMonitor performanceMonitor})
      : _performanceMonitor = performanceMonitor;

  @override
  Widget build(BuildContext context) {
    return Text('FPS: ${_performanceMonitor.fps.toStringAsFixed(2)}');
  }
}
