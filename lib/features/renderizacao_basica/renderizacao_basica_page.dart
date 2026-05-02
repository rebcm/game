import 'package:flutter/material.dart';
import 'package:three_dart/three_dart.dart' as three;

class RenderizacaoBasicaPage extends StatefulWidget {
  @override
  _RenderizacaoBasicaPageState createState() => _RenderizacaoBasicaPageState();
}

class _RenderizacaoBasicaPageState extends State<RenderizacaoBasicaPage> {
  three.Scene _scene;
  three.Camera _camera;
  three.Renderer _renderer;

  @override
  void initState() {
    super.initState();
    _initThree();
  }

  void _initThree() {
    _scene = three.Scene();
    _camera = three.PerspectiveCamera(75, 1, 0.1, 1000);
    _renderer = three.WebGLRenderer(
      antialias: true,
      canvas: null,
    );
    _camera.position.z = 5;
    three.Mesh sphere = three.Mesh(
      three.SphereGeometry(1, 32, 32),
      three.MeshBasicMaterial(color: three.Color(0xff0000)),
    );
    _scene.add(sphere);
    _renderer.render(_scene, _camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Renderização Básica'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: three.CanvasThreeObject(_renderer),
        ),
      ),
    );
  }
}
