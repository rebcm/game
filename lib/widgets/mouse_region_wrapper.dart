import 'package:flutter/material.dart';

class MouseRegionWrapper extends StatelessWidget {
  final Widget child;

  const MouseRegionWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onEnter(context),
      onExit: (event) => _onExit(context),
      child: child,
    );
  }

  void _onEnter(BuildContext context) {
    // Implement hover enter logic here
  }

  void _onExit(BuildContext context) {
    // Implement hover exit logic here
  }
}
