import 'package:flutter/material.dart';
import 'package:rebcm/utils/image_cache.dart';

class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  final double? cacheWidth;
  final double? cacheHeight;

  const OptimizedImage({
    Key? key,
    required this.imageUrl,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageCacheManager.cachedImage(imageUrl, cacheWidth: cacheWidth, cacheHeight: cacheHeight);
  }
}
