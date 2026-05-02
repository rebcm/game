import 'package:latlong2/latlong.dart';

abstract class IChunkingSystemRepository {
  Future<List<Chunk>> getChunksAroundLocation(LatLng location, double radius);
  Future<void> updateChunk(Chunk chunk);
}

class Chunk {
  final LatLng center;
  final double radius;
  final List<dynamic> data; // adjust type according to the actual data stored

  Chunk({required this.center, required this.radius, required this.data});
}
