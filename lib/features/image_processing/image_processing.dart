import 'package:flutter/material.dart';
class ImageProcessing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/image.png', filterQuality: FilterQuality.none);
  }
}
