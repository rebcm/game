import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCacheManager {
  static Widget cachedImage(String url, {double? cacheWidth, double? cacheHeight}) {
    return CachedNetworkImage(
      imageUrl: url,
      cacheKey: url,
      width: cacheWidth,
      height: cacheHeight,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
