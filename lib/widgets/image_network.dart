import 'package:flutter/material.dart';
import 'package:rebcm/utils/image_cache.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? cacheWidth;
  final double? cacheHeight;

  const ImageNetworkWidget({
    Key? key,
    required this.imageUrl,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageCacheWidget(
      imageUrl: imageUrl,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }
}
