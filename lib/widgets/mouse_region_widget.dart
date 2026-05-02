import 'package:flutter/material.dart';

class MouseRegionWidget extends StatefulWidget {
  final Widget child;

  const MouseRegionWidget({Key? key, required this.child}) : super(key: key);

  @override
  _MouseRegionWidgetState createState() => _MouseRegionWidgetState();
}

class _MouseRegionWidgetState extends State<MouseRegionWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.child,
    );
  }
}
