import 'dart:math';

class Posicao3D {
  final int x;
  final int y;
  final int z;

  const Posicao3D(this.x, this.y, this.z);

  Posicao3D operator +(Posicao3D outro) =>
      Posicao3D(x + outro.x, y + outro.y, z + outro.z);

  Posicao3D operator -(Posicao3D outro) =>
      Posicao3D(x - outro.x, y - outro.y, z - outro.z);

  double distanciaPara(Posicao3D outro) {
    final dx = x - outro.x;
    final dy = y - outro.y;
    final dz = z - outro.z;
    return sqrt(dx * dx + dy * dy + dz * dz).toDouble();
  }

  List<Posicao3D> get vizinhos => [
    Posicao3D(x + 1, y, z),
    Posicao3D(x - 1, y, z),
    Posicao3D(x, y + 1, z),
    Posicao3D(x, y - 1, z),
    Posicao3D(x, y, z + 1),
    Posicao3D(x, y, z - 1),
  ];

  @override
  bool operator ==(Object outro) =>
      outro is Posicao3D && x == outro.x && y == outro.y && z == outro.z;

  @override
  int get hashCode => Object.hash(x, y, z);

  @override
  String toString() => 'Posicao3D($x, $y, $z)';
}
