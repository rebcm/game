import 'package:flutter/material.dart';

class RepaintRainbow extends StatelessWidget {
  final Widget child;

  const RepaintRainbow({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.withOpacity(0.5)),
        ),
        child: child,
      ),
    );
  }
}
