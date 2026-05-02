import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageResizer {
  static Future<Image> resizeImage(String url, {required double width, required double height}) async {
    final Uint8List bytes = await _loadImageBytes(url);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: width.round(), targetHeight: height.round());
    final ui.FrameInfo frame = await codec.getNextFrame();
    return Image(
      image: frame.image,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  static Future<Uint8List> _loadImageBytes(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
