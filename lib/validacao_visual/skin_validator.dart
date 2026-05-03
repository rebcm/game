import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class SkinValidator {
  Future<bool> validateSkinDimensions() async {
    final Uint8List bytes = (await rootBundle.load('assets/blocos/skin.png')).buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image.width == 64 && frame.image.height == 64;
  }
}
