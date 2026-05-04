import 'package:flutter/material.dart';
import 'package:game/rendering/texture_config.dart';

class Renderer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Texture(
      filterQuality: TextureConfig.filterQuality,
      // Other texture properties...
    );
  }
}
