import 'package:flutter/material.dart';
import 'package:rebcm/widgets/texture_widget.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextureWidget(
      texture: Image.asset('assets/blocos/bloco.png'),
    );
  }
}
