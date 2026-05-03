import 'package:three_dart/three_dart.dart' as three;

class ThreeRenderer {
  late three.Scene _scene;
  late three.Camera _camera;
  late three.Renderer _renderer;

  void init() {
    _scene = three.Scene();
    _camera = three.PerspectiveCamera(75, 1, 0.1, 1000);
    _renderer = three.WebGLRenderer(
      antialias: true,
      canvas: null, // Será definido posteriormente
    );
  }

  void render() {
    _renderer.render(_scene, _camera);
  }
}

