import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/inventario/inventario.dart';
import 'package:rebcm/inventario/item.dart';
import 'package:rebcm/mundo/chunk.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Persistência do mundo via [SharedPreferences].
///
/// Cada chunk dirty é salvo como blob binário comprimido (gzip), de forma que
/// quebras de blocos (= bloco virou ar) também persistem corretamente.
///
/// Layout JSON:
/// ```
/// {
///   "v": 1,            // versão do schema
///   "seed": 42,
///   "p": {x,y,z},      // posição do player
///   "slot": 0,         // hotbar slot
///   "hp": 20,          // opcional
///   "fome": 20,
///   "td": 0.25,        // tempoDia
///   "chunks": [
///     { "cx": 0, "cz": 0, "data": "<base64(gzip(uint8list))>" }
///   ]
/// }
/// ```
/// O JSON inteiro é também gzipado e base64-codificado para caber em
/// SharedPreferences (que aceita strings).
class SaveLoad {
  static const String _kSlot = 'rebcm_save_slot_default';

  static Future<bool> salvar({
    required ChunkMundo chunks,
    required double px,
    required double py,
    required double pz,
    required int hotbarSlot,
    int? hp,
    int? fome,
    double? tempoDia,
    List<Map<String, Object>>? inventario,
  }) async {
    try {
      final chunksList = <Map<String, Object>>[];
      for (final chunk in chunks.todosChunks()) {
        if (!chunk.dirty) continue;
        final compressed = GZipEncoder().encode(chunk.blocos) ?? chunk.blocos;
        chunksList.add({
          'cx': chunk.cx,
          'cz': chunk.cz,
          'data': base64Encode(compressed),
        });
      }

      final json = <String, Object>{
        'v': Constantes.saveVersion,
        'seed': chunks.seed,
        'p': {'x': px, 'y': py, 'z': pz},
        'slot': hotbarSlot,
        if (hp != null) 'hp': hp,
        if (fome != null) 'fome': fome,
        if (tempoDia != null) 'td': tempoDia,
        if (inventario != null) 'inv': inventario,
        'chunks': chunksList,
      };

      final raw = utf8.encode(jsonEncode(json));
      final compressed = GZipEncoder().encode(raw) ?? raw;
      final encoded = base64Encode(compressed);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kSlot, encoded);

      for (final c in chunks.todosChunks()) {
        chunks.marcarLimpo(c);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<SaveData?> carregar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = prefs.getString(_kSlot);
      if (encoded == null || encoded.isEmpty) return null;

      final compressed = base64Decode(encoded);
      final raw = GZipDecoder().decodeBytes(compressed);
      final decoded = jsonDecode(utf8.decode(raw));
      if (decoded is! Map<String, Object?>) return null;

      final v = decoded['v'];
      if (v != Constantes.saveVersion) return null;

      final seed = decoded['seed'] as int? ?? 42;
      final p = decoded['p'] as Map<String, Object?>? ?? const {};
      final px = (p['x'] as num?)?.toDouble() ?? Constantes.worldX / 2.0;
      final py = (p['y'] as num?)?.toDouble() ?? 20.0;
      final pz = (p['z'] as num?)?.toDouble() ?? Constantes.worldZ / 2.0;
      final slot = decoded['slot'] as int? ?? 0;
      final hp = decoded['hp'] as int?;
      final fome = decoded['fome'] as int?;
      final tempoDia = (decoded['td'] as num?)?.toDouble();

      final chunksList = <SaveChunk>[];
      final chunksRaw = decoded['chunks'];
      if (chunksRaw is List) {
        for (final e in chunksRaw) {
          if (e is! Map) continue;
          final cx = e['cx'] as int?;
          final cz = e['cz'] as int?;
          final data = e['data'] as String?;
          if (cx == null || cz == null || data == null) continue;
          final bytes = GZipDecoder().decodeBytes(base64Decode(data));
          if (bytes.length != Constantes.chunkSize *
              Constantes.chunkSize *
              Constantes.worldY) {
            continue; // tamanho incompatível — pular
          }
          chunksList.add(SaveChunk(cx, cz, Uint8List.fromList(bytes)));
        }
      }

      // Inventário (opcional, presente em saves v3+).
      List<Map<String, Object?>>? invList;
      final invRaw = decoded['inv'];
      if (invRaw is List) {
        invList = invRaw
            .whereType<Map>()
            .map((m) => m.map<String, Object?>((k, v) => MapEntry(k.toString(), v)))
            .toList();
      }

      return SaveData(
        seed: seed,
        px: px,
        py: py,
        pz: pz,
        hotbarSlot: slot,
        hp: hp,
        fome: fome,
        tempoDia: tempoDia,
        chunks: chunksList,
        inventario: invList,
      );
    } catch (_) {
      return null;
    }
  }

  /// Sobrescreve chunks no [ChunkMundo] com as bytes do save.
  static void aplicarOverrides(ChunkMundo chunks, SaveData data) {
    for (final sc in data.chunks) {
      chunks.injetarChunk(sc.cx, sc.cz, sc.blocos);
    }
  }

  /// Serializa o inventário para uma lista de mapas JSON-friendly.
  /// Cada slot vira `{i: <slot_index>, b: <bloco_index>?, t: <item_index>?, q: <qtd>}`.
  static List<Map<String, Object>> serializarInventario(Inventario inv) {
    final out = <Map<String, Object>>[];
    for (int i = 0; i < inv.slots.length; i++) {
      final s = inv.slots[i];
      if (s == null) continue;
      final entry = <String, Object>{'i': i, 'q': s.qtd};
      if (s.isBloco) entry['b'] = s.bloco!.index;
      if (s.isItem) entry['t'] = s.item!.index;
      out.add(entry);
    }
    return out;
  }

  /// Aplica uma lista serializada ao inventário (limpando-o antes).
  static void aplicarInventario(Inventario inv, List<Map<String, Object?>> data) {
    inv.limpar();
    for (final e in data) {
      final i = e['i'] as int?;
      final q = e['q'] as int?;
      if (i == null || q == null || i < 0 || i >= inv.slots.length) continue;
      final bIdx = e['b'] as int?;
      final tIdx = e['t'] as int?;
      if (bIdx != null && bIdx >= 0 && bIdx < TipoBloco.values.length) {
        inv.slots[i] = Item.bloco(TipoBloco.values[bIdx], qtd: q);
      } else if (tIdx != null && tIdx >= 0 && tIdx < TipoItem.values.length) {
        inv.slots[i] = Item.item(TipoItem.values[tIdx], qtd: q);
      }
    }
  }

  static Future<bool> apagar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_kSlot);
  }

  static Future<bool> existeSave() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_kSlot);
  }
}

class SaveChunk {
  final int cx;
  final int cz;
  final Uint8List blocos;
  const SaveChunk(this.cx, this.cz, this.blocos);
}

class SaveData {
  final int seed;
  final double px, py, pz;
  final int hotbarSlot;
  final int? hp;
  final int? fome;
  final double? tempoDia;
  final List<SaveChunk> chunks;
  final List<Map<String, Object?>>? inventario;

  const SaveData({
    required this.seed,
    required this.px,
    required this.py,
    required this.pz,
    required this.hotbarSlot,
    this.hp,
    this.fome,
    this.tempoDia,
    required this.chunks,
    this.inventario,
  });
}
