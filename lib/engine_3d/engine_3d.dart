import 'package:flutter_gl/flutter_gl.dart';

class Engine3D {
  final FlutterGl _flutterGl;

  Engine3D(this._flutterGl);

  void render() {
    // Implement 3D rendering logic here
    _flutterGl.render();
  }

  void update() {
    // Implement 3D update logic here
  }
}
