import 'package:rebcm/mundo/gerador_otimizado.dart';

class GeradorMundo {
  static Chunk gerarChunk(int x, int z) {
    return GeradorMundoOtimizado.gerarChunk(x, z);
  }
}
