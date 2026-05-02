class Constantes {
  static const String nomeJogo = Intl.message('Construção Criativa da Rebeca');
  static const String versao = Intl.message('0.1.0');
  static const String autora = Intl.message('Rebeca Alves Moreira');

  static const int tamanhoChunk = 16;
  static const int alturaMaxima = 64;
  static const int alturaMinima = 0;

  static const double tamanhoBloco = 32.0;
  static const double velocidadePersonagem = 4.0;
  static const int totalBlocosInventario = 9;

  // Rede
  static const String urlApi = Intl.message('https://construcao-criativa.workers.dev');
  static const Duration timeoutRequisicao = Duration(seconds: 10);
}
