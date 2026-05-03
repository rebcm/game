import 'package:equatable/equatable.dart';

class Chunk extends Equatable {
  final int x;
  final int z;

  Chunk({required this.x, required this.z});

  @override
  List<Object?> get props => [x, z];
}
