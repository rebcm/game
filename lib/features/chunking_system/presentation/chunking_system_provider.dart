import 'package:flutter/material.dart';
import 'package:passdriver/features/chunking_system/data/chunking_system_repository.dart';
import 'package:latlong2/latlong.dart';

class ChunkingSystemProvider with ChangeNotifier {
  final ChunkingSystemRepository _repository;

  ChunkingSystemProvider(this._repository);

  List<Chunk> _chunks = [];

  List<Chunk> get chunks => _chunks;

  Future<void> loadChunksAroundLocation(LatLng location, double radius) async {
    final chunks = await _repository.getChunksAroundLocation(location, radius);
    _chunks = chunks;
    notifyListeners();
  }
}
