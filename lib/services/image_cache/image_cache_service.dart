import 'package:flutter/material.dart';
import 'package:rebcm/utils/image_processing/image_resizer.dart';

class ImageCacheService {
  final Map<String, Image> _cache = {};

  Image? get(String url) => _cache[url];

  void set(String url, Image image) => _cache[url] = image;

  Future<Image> loadAndResize(String url, {required double width, required double height}) async {
    final image = await ImageResizer.resizeImage(url, width: width, height: height);
    set(url, image);
    return image;
  }
}
