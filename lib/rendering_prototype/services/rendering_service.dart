import 'package:flutter/material.dart';
import 'package:game/rendering_prototype/models/cube_model.dart';

class RenderingService with ChangeNotifier {
  final CubeModel _cubeModel = CubeModel();

  List<Vector3> getVertices() => _cubeModel.getVertices();
  List<int> getIndices() => _cubeModel.getIndices();

  void render() {
    // Implement rendering logic here using the selected library
    // For now, just print the vertices and indices
    print('Vertices: ${_cubeModel.getVertices()}');
    print('Indices: ${_cubeModel.getIndices()}');
  }
}
