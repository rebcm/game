import 'package:flutter/material.dart';

class HUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => print('HUD Mouse entered'),
      onExit: (event) => print('HUD Mouse exited'),
      child: Container(
        // Existing HUD content here
      ),
    );
  }
}
