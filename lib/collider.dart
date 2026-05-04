class Collider {
  final double _x;
  bool _isActive = false;

  Collider(this._x);

  double get position => _x;

  bool get isActive => _isActive;

  set isActive(bool value) => _isActive = value;
}
