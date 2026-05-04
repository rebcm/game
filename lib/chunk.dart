import 'package:game/collider.dart';

class Chunk {
  final int _x;
  final int _z;
  final List<Collider> _colliders = [];

  Chunk(this._x, this._z);

  List<Collider> get colliders => _colliders;

  void loadColliders() {
    // Logic to load colliders for the chunk
    _colliders.add(Collider(_x * 16, _z * 16));
  }

  void updateColliders() {
    _colliders.forEach((collider) {
      collider.isActive = true;
    });
  }
}
