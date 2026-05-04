import 'package:freezed/freezed.dart';

part 'mundo_estado.freezed.dart';
part 'mundo_estado.g.dart';

@freezed
class MundoEstado with _$MundoEstado {
  const factory MundoEstado({
    required PosicaoJogador posicaoJogador,
    required List<Chunk> blocosMundo,
    required MetadadosMundo metadadosMundo,
  }) = _MundoEstado;

  factory MundoEstado.fromJson(Map<String, dynamic> json) => _$MundoEstadoFromJson(json);
}

@freezed
class PosicaoJogador with _$PosicaoJogador {
  const factory PosicaoJogador({
    required double x,
    required double y,
    required double z,
  }) = _PosicaoJogador;

  factory PosicaoJogador.fromJson(Map<String, dynamic> json) => _$PosicaoJogadorFromJson(json);
}

@freezed
class Chunk with _$Chunk {
  const factory Chunk({
    required String chunkId,
    required List<List<List<int>>> blocos,
  }) = _Chunk;

  factory Chunk.fromJson(Map<String, dynamic> json) => _$ChunkFromJson(json);
}

@freezed
class MetadadosMundo with _$MetadadosMundo {
  const factory MetadadosMundo({
    required List<int> tamanhoMundo,
    required String versaoSchema,
  }) = _MetadadosMundo;

  factory MetadadosMundo.fromJson(Map<String, dynamic> json) => _$MetadadosMundoFromJson(json);
}
