import 'package:flutter/material.dart';
import 'package:rebcm/widgets/mouse_region_widget.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegionWidget(
        child: // Your game content here
            Container(),
      ),
    );
  }
}
