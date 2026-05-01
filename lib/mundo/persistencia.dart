import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocos/tipo_bloco.dart';
import '../config/constantes.dart';
import 'chunk.dart';
import 'mundo.dart';
import 'posicao3d.dart';

class PersistenciaMundo {
  static const _prefixoChunk = 'chunk_';
  static const _chaveRebecaX = 'rebeca_x';
  static const _chaveRebecaY = 'rebeca_y';
  static const _chaveRebecaZ = 'rebeca_z';
  static const _chaveSemente = 'semente';
  static const _chaveNome = 'nome_mundo';
  static const _chaveExiste = 'mundo_salvo';

  static Future<bool> mundoExiste() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chaveExiste) ?? false;
  }

  static Future<void> salvarPosicao(double x, double y, double z) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_chaveRebecaX, x);
    await prefs.setDouble(_chaveRebecaY, y);
    await prefs.setDouble(_chaveRebecaZ, z);
  }

  static Future<Posicao3D?> carregarPosicao() async {
    final prefs = await SharedPreferences.getInstance();
    final x = prefs.getDouble(_chaveRebecaX);
    final y = prefs.getDouble(_chaveRebecaY);
    final z = prefs.getDouble(_chaveRebecaZ);
    if (x == null || y == null || z == null) return null;
    return Posicao3D(x.floor(), y.floor(), z.floor());
  }

  static Future<void> salvarChunk(Chunk chunk) async {
    final prefs = await SharedPreferences.getInstance();
    final chave = '$_prefixoChunk${chunk.chunkX}_${chunk.chunkZ}';

    final blocos = <int>[];
    for (var x = 0; x < Constantes.tamanhoChunk; x++) {
      for (var y = 0; y < Constantes.alturaMaxima; y++) {
        for (var z = 0; z < Constantes.tamanhoChunk; z++) {
          blocos.add(chunk.pegarBloco(x, y, z).index);
        }
      }
    }

    await prefs.setString(chave, jsonEncode(blocos));
    await prefs.setBool(_chaveExiste, true);
  }

  static Future<Chunk?> carregarChunk(int cx, int cz) async {
    final prefs = await SharedPreferences.getInstance();
    final chave = '$_prefixoChunk${cx}_$cz';
    final dados = prefs.getString(chave);
    if (dados == null) return null;

    final blocos = (jsonDecode(dados) as List).cast<int>();
    final chunk = Chunk(chunkX: cx, chunkZ: cz);
    var idx = 0;

    for (var x = 0; x < Constantes.tamanhoChunk; x++) {
      for (var y = 0; y < Constantes.alturaMaxima; y++) {
        for (var z = 0; z < Constantes.tamanhoChunk; z++) {
          if (idx < blocos.length) {
            chunk.definirBloco(x, y, z, TipoBloco.values[blocos[idx]]);
          }
          idx++;
        }
      }
    }
    chunk.modificado = false;
    return chunk;
  }

  static Future<void> salvarMundo(Mundo mundo, String nome, int semente) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_chaveSemente, semente);
    await prefs.setString(_chaveNome, nome);

    for (final chunk in mundo.chunksModificados) {
      await salvarChunk(chunk);
    }
  }

  static Future<int?> carregarSemente() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_chaveSemente);
  }

  static Future<String> carregarNome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveNome) ?? 'Mundo da Rebeca';
  }

  static Future<void> limparMundo() async {
    final prefs = await SharedPreferences.getInstance();
    final chaves = prefs.getKeys().where((k) => k.startsWith(_prefixoChunk));
    for (final chave in chaves) {
      await prefs.remove(chave);
    }
    await prefs.setBool(_chaveExiste, false);
    await prefs.remove(_chaveRebecaX);
    await prefs.remove(_chaveRebecaY);
    await prefs.remove(_chaveRebecaZ);
    await prefs.remove(_chaveSemente);
    await prefs.remove(_chaveNome);
  }
}
