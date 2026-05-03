import 'package:game/dicas.dart';

void main() {
  final dicas = Dicas().getDicas();
  final estruturas = EstruturasSugeridas().getEstruturas();

  // Extract and validate dicas content
  for (var dica in dicas) {
    print(dica.titulo);
    print(dica.descricao);
  }

  for (var estrutura in estruturas) {
    print(estrutura.nome);
    print(estrutura.descricao);
  }
}
