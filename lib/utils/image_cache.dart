import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCache {
  static void init() {
    CachedNetworkImage.imageCache = CacheManager(
      Config(
        maxWidth: 500,
        maxHeight: 500,
        max_entries: 100,
        stalePeriod: Duration(days: 7),
      ),
    );
  }

  static Widget cachedImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
