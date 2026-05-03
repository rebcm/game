import 'package:flutter/material.dart';

class CubeModel {
  final List<Vector3> vertices = [
    Vector3(-1, -1, -1),
    Vector3(1, -1, -1),
    Vector3(1, 1, -1),
    Vector3(-1, 1, -1),
    Vector3(-1, -1, 1),
    Vector3(1, -1, 1),
    Vector3(1, 1, 1),
    Vector3(-1, 1, 1),
  ];

  final List<int> indices = [
    0, 1, 2, 0, 2, 3, // Front face
    1, 5, 6, 1, 6, 2, // Right face
    5, 4, 7, 5, 7, 6, // Back face
    4, 0, 3, 4, 3, 7, // Left face
    4, 5, 1, 4, 1, 0, // Bottom face
    3, 2, 6, 3, 6, 7, // Top face
  ];

  List<Vector3> getVertices() => vertices;
  List<int> getIndices() => indices;
}
