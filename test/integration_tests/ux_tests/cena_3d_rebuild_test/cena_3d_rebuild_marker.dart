import 'package:flutter/material.dart';

class RebuildMarker extends StatelessWidget {
  final Widget child;

  RebuildMarker({required this.child});

  @override
  Widget build(BuildContext context) {
    print('RebuildMarker build called');
    return child;
  }
}
