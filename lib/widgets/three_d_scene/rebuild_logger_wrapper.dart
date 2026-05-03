import 'package:flutter/material.dart';
import 'package:game/utils/performance_testing/rebuild_logger.dart';

class RebuildLoggerWrapper extends StatefulWidget {
  final Widget child;
  final String widgetName;

  const RebuildLoggerWrapper({Key? key, required this.child, required this.widgetName}) : super(key: key);

  @override
  State<RebuildLoggerWrapper> createState() => _RebuildLoggerWrapperState();
}

class _RebuildLoggerWrapperState extends State<RebuildLoggerWrapper> {
  late final RebuildLogger _rebuildLogger;

  @override
  void initState() {
    super.initState();
    _rebuildLogger = RebuildLogger(widget.widgetName);
  }

  @override
  Widget build(BuildContext context) {
    _rebuildLogger.logRebuild();
    return widget.child;
  }
}
