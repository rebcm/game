import 'package:json_annotation/json_annotation.dart';

part 'entidades.g.dart';

@JsonSerializable()
class BlocoVoxel {
  int tipoBloco;
  int posicaoX;
  int posicaoY;
  int posicaoZ;
  bool estado;

  BlocoVoxel({required this.tipoBloco, required this.posicaoX, required this.posicaoY, required this.posicaoZ, required this.estado});

  factory BlocoVoxel.fromJson(Map<String, dynamic> json) => _$BlocoVoxelFromJson(json);
  Map<String, dynamic> toJson() => _$BlocoVoxelToJson(this);
}

@JsonSerializable()
class Chunk {
  List<BlocoVoxel> blocos;

  Chunk({required this.blocos});

  factory Chunk.fromJson(Map<String, dynamic> json) => _$ChunkFromJson(json);
  Map<String, dynamic> toJson() => _$ChunkToJson(this);
}

@JsonSerializable()
class ConfiguracaoAudio {
  double volume;
  String codec;
  bool estadoReproducao;

  ConfiguracaoAudio({required this.volume, required this.codec, required this.estadoReproducao});

  factory ConfiguracaoAudio.fromJson(Map<String, dynamic> json) => _$ConfiguracaoAudioFromJson(json);
  Map<String, dynamic> toJson() => _$ConfiguracaoAudioToJson(this);
}

@JsonSerializable()
class MetadadoAsset {
  String caminhoArquivo;
  int dimensaoX;
  int dimensaoY;
  String formato;

  MetadadoAsset({required this.caminhoArquivo, required this.dimensaoX, required this.dimensaoY, required this.formato});

  factory MetadadoAsset.fromJson(Map<String, dynamic> json) => _$MetadadoAssetFromJson(json);
  Map<String, dynamic> toJson() => _$MetadadoAssetToJson(this);
}
