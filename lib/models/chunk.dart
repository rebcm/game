import 'package:flutter_gl/flutter_gl.dart';

class Chunk with EquatableMixin {
  final int x;
  final int z;

  Chunk(this.x, this.z);

  @override
  List<Object> get props => [x, z];
}
