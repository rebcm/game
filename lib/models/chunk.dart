import 'package:equatable/equatable.dart';

class Chunk extends Equatable {
  final int x;
  final int y;
  final int z;

  const Chunk({required this.x, required this.y, required this.z});

  @override
  List<Object> get props => [x, y, z];
}
