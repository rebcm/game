import 'package:flutter/material.dart';

class RebuildMonitor extends StatefulWidget {
  final Widget child;

  RebuildMonitor({required this.child});

  @override
  _RebuildMonitorState createState() => _RebuildMonitorState();
}

class _RebuildMonitorState extends State<RebuildMonitor> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    print('RebuildMonitor build');
    return widget.child;
  }
}
