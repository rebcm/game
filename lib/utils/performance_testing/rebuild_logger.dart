import 'package:flutter/material.dart';

class RebuildLogger with DiagnosticableTreeMixin {
  final String widgetName;

  RebuildLogger({required this.widgetName});

  void logRebuild() {
    debugPrint('RebuildLogger: $widgetName rebuilt');
  }
}

class RebuildLoggerWrapper extends StatefulWidget {
  final Widget child;
  final String widgetName;

  const RebuildLoggerWrapper({Key? key, required this.child, required this.widgetName}) : super(key: key);

  @override
  State<RebuildLoggerWrapper> createState() => _RebuildLoggerWrapperState();
}

class _RebuildLoggerWrapperState extends State<RebuildLoggerWrapper> {
  final RebuildLogger _rebuildLogger = RebuildLogger(widgetName: '');

  @override
  void initState() {
    super.initState();
    _rebuildLogger.widgetName = widget.widgetName;
  }

  @override
  Widget build(BuildContext context) {
    _rebuildLogger.logRebuild();
    return widget.child;
  }
}
