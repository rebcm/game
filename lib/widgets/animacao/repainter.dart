import 'package:flutter/material.dart';

class Repainter extends StatelessWidget {
  final Widget child;

  const Repainter({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: child);
  }
}
