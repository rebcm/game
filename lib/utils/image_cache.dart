import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCacheWidget extends StatelessWidget {
  final String imageUrl;
  final double? cacheWidth;
  final double? cacheHeight;

  const ImageCacheWidget({
    Key? key,
    required this.imageUrl,
    this.cacheWidth,
    this.cacheHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: cacheWidth,
      height: cacheHeight,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
