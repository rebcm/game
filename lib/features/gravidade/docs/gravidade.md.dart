/// Documentação do vetor de gravidade global e zonas de gravidade alterada
library;

/// Vetor de gravidade global
const Vector3 globalGravity = Vector3(0, 0, -9.8);

/// Zonas de gravidade alterada ou ausência de gravidade para objetos específicos
class GravityZone {
  final double latitude;
  final double longitude;
  final double altitude;
  final Vector3 gravity;

  GravityZone({required this.latitude, required this.longitude, required this.altitude, required this.gravity});
}
