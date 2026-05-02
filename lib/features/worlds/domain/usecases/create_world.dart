import 'package:dartz/dartz.dart';
import '../entities/world.dart';
import '../repositories/world_repository.dart';

class CreateWorld {
  final WorldRepository _repository;

  CreateWorld(this._repository);

  Future<Either<String, World>> call(String name) async {
    final result = await _repository.createWorld(name);
    return result.map((id) => World(id: id, name: name));
  }
}
