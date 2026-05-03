/// Descrição dos biomas do jogo.
///
/// Atualmente, o jogo suporta um único bioma criativo.
class Bioma {
  /// Nome do bioma.
  final String nome;

  /// Descrição detalhada do bioma.
  final String descricao;

  Bioma({required this.nome, required this.descricao});

  /// Bioma padrão do jogo.
  static Bioma biomaPadrao = Bioma(
    nome: 'Bioma Padrão',
    descricao: 'Um mundo criativo onde os jogadores têm liberdade para construir e explorar.',
  );
}

