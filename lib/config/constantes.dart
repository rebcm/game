class Constantes {
  static const String nomeJogo = 'Construção Criativa da Rebeca';
  static const String versao = '0.1.0';
  static const String autora = 'Rebeca Alves Moreira';

  static const int tamanhoChunk = 16;
  static const int alturaMaxima = 64;
  static const int alturaMinima = 0;

  static const double tamanhoBloco = 32.0;
  static const double velocidadePersonagem = 4.0;
  static const int totalBlocosInventario = 9;

  // Rede
  static const String urlApi = 'https://construcao-criativa.workers.dev';
  static const Duration timeoutRequisicao = Duration(seconds: 10);
}
