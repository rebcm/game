import 'package:flutter/material.dart';

class TextureWidget extends StatelessWidget {
  final Image texture;

  const TextureWidget({Key? key, required this.texture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: texture.image,
      filterQuality: FilterQuality.none,
    );
  }
}
