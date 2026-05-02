import 'package:vector_math/vector_math.dart';

class Frustum {
  final double _width;
  final double _height;
  final double _maxDistance;

  late Matrix4 _projectionMatrix;
  late Matrix4 _viewMatrix;
  late Matrix4 _frustumMatrix;

  Frustum(this._width, this._height, this._maxDistance) {
    _projectionMatrix = Matrix4.perspective(0.1, _maxDistance, 45 * 3.141592 / 180, _width / _height);
    _viewMatrix = Matrix4.identity(); // Ajustar conforme necessário
    _frustumMatrix = _projectionMatrix * _viewMatrix;
  }

  bool isVisible(double x, double y, double z) {
    Vector4 point = Vector4(x, y, z, 1);
    Vector4 transformedPoint = _frustumMatrix.transform(point);

    return transformedPoint.x >= -transformedPoint.w &&
           transformedPoint.x <= transformedPoint.w &&
           transformedPoint.y >= -transformedPoint.w &&
           transformedPoint.y <= transformedPoint.w &&
           transformedPoint.z >= -transformedPoint.w &&
           transformedPoint.z <= transformedPoint.w;
  }
}
