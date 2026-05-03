import 'package:flutter/material.dart';

class SceneLogger extends StatefulWidget {
  final Widget child;

  SceneLogger({required this.child});

  @override
  _SceneLoggerState createState() => _SceneLoggerState();
}

class _SceneLoggerState extends State<SceneLogger> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(SceneLogger oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Log rebuilds
    print('SceneLogger: Rebuild detected');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
