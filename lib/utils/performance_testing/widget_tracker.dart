import 'package:flutter/material.dart';
import 'package:game/utils/performance_testing/performance_tester.dart';

class RebuildTrackingWrapper extends StatefulWidget {
  final Widget child;

  RebuildTrackingWrapper({required this.child});

  @override
  _RebuildTrackingWrapperState createState() => _RebuildTrackingWrapperState();
}

class _RebuildTrackingWrapperState extends State<RebuildTrackingWrapper> {
  @override
  Widget build(BuildContext context) {
    PerformanceTester().incrementRebuildCount();
    return widget.child;
  }
}
