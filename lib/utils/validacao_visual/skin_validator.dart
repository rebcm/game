import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class SkinValidator {
  Future<bool> validateDimensions() async {
    final Uint8List bytes = await (await rootBundle.load('assets/blocos/skin.png')).buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image.width == 64 && frame.image.height == 64;
  }

  Future<bool> validateColorPalette() async {
    // Implementar logica para validar paleta de cores
    return true;
  }

  Future<bool> validateOuterLayer() async {
    // Implementar logica para verificar camada externa
    return true;
  }
}
