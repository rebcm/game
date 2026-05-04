import 'package:flutter/material.dart';

class TextureRenderer extends StatelessWidget {
  const TextureRenderer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/texture.png'),
      filterQuality: FilterQuality.none,
      key: const Key('voxel_block'),
    );
  }
}
