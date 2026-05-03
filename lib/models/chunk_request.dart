import 'package:equatable/equatable.dart';

class ChunkRequest extends Equatable {
  final int x;
  final int z;

  const ChunkRequest({required this.x, required this.z});

  @override
  List<Object> get props => [x, z];
}
