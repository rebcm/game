import 'package:flutter/material.dart';

enum ArmType { classic, slim }

class ArmTexture extends StatelessWidget {
  final ArmType armType;
  final Image texture;

  const ArmTexture({
    Key? key,
    required this.armType,
    required this.texture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (armType == null) {
      throw AssertionError('Arm type cannot be null');
    }

    // Implement texture mapping logic based on armType
    // For demonstration purposes, just return the texture
    return texture;
  }
}
