import 'package:flutter/material.dart';
import 'package:rebcm/utils/image_cache.dart';

class ImageWidget extends StatelessWidget {
  final String url;

  const ImageWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageCache.cachedImage(url);
  }
}
