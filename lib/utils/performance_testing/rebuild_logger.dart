import 'package:flutter/material.dart';

class RebuildLogger with DiagnosticableTreeMixin {
  final String _widgetName;

  RebuildLogger(this._widgetName);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return _widgetName;
  }

  void logRebuild() {
    debugPrint('Rebuild: $_widgetName');
  }
}
