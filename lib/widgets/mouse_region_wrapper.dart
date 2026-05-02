import 'package:flutter/material.dart';

class MouseRegionWrapper extends StatefulWidget {
  final Widget child;

  const MouseRegionWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _MouseRegionWrapperState createState() => _MouseRegionWrapperState();
}

class _MouseRegionWrapperState extends State<MouseRegionWrapper> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: widget.child,
    );
  }
}
