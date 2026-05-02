import 'package:flutter/material.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

class AnalisadorPerformance with ChangeNotifier {
  bool _repaintRainbow = false;

  bool get repaintRainbow => _repaintRainbow;

  void toggleRepaintRainbow() {
    _repaintRainbow = !_repaintRainbow;
    notifyListeners();
  }

  Widget wrapWithRepaintRainbow(Widget widget) {
    return _repaintRainbow
        ? RepaintBoundary(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: widget,
            ),
          )
        : widget;
  }
}
