import 'package:rebcm/blocos/bloco.dart';

class BlocosDisponiveis {
  static List<Bloco> listaBlocos = [
    Bloco(nome: 'Grama', descricao: 'Um bloco de grama.', categoria: 'Natureza'),
    Bloco(nome: 'Dirt', descricao: 'Um bloco de terra.', categoria: 'Natureza'),
    Bloco(nome: 'Stone', descricao: 'Um bloco de pedra.', categoria: 'Natureza'),
    // Adicione mais blocos aqui...
  ];

  static Map<String, List<Bloco>> blocosPorCategoria() {
    final map = <String, List<Bloco>>{};
    for (var bloco in listaBlocos) {
      if (!map.containsKey(bloco.categoria)) {
        map[bloco.categoria] = [];
      }
      map[bloco.categoria]!.add(bloco);
    }
    return map;
  }
}
