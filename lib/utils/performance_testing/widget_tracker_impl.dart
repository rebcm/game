import 'package:flutter/material.dart';
import 'package:rebcm/utils/performance_testing/widget_tracker.dart';

class RebuildTracker extends StatefulWidget {
  final Widget child;
  final WidgetTracker tracker;

  RebuildTracker({required this.child, required this.tracker});

  @override
  _RebuildTrackerState createState() => _RebuildTrackerState();
}

class _RebuildTrackerState extends State<RebuildTracker> {
  @override
  Widget build(BuildContext context) {
    widget.tracker.incrementRebuildCount();
    return widget.child;
  }
}
