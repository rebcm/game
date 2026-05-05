class Constantes {
  static const String autora = 'Rebeca Alves Moreira';
  static const String nomejogo = 'Construção Criativa da Rebeca';

  // Tamanho do tile isométrico.
  static const double halfW = 28.0;
  static const double halfH = 14.0;
  static const double sideH = 28.0;

  // === Mundo por chunks ===
  // O mundo é dividido em chunks de [chunkSize] × [worldY] × [chunkSize] blocos.
  // Não há mais worldX/worldZ fixos — o mundo é virtualmente infinito,
  // gerado sob demanda. worldX/worldZ permanecem como referência para o
  // save legacy (single-chunk inicial 32×32).
  static const int chunkSize = 16;
  static const int worldY = 64;

  // Quantidade de chunks visíveis em cada eixo a partir do player. Um valor
  // de 4 = 9×9 chunks = 144×144 blocos visíveis. Pode ajustar para perf.
  static const int viewRadius = 3;

  // === Compat: dimensões do mundo legacy (32×32×20) ===
  // Mantidos para chamadas antigas; usados como ponto de spawn padrão.
  static const int worldX = 32;
  static const int worldZ = 32;

  // Gameplay
  static const double velocidade = 5.0;
  static const double tempoQuebra = 0.8;
  static const double alcanceBloco = 6.0;

  // === Save / Load ===
  // Versão do schema de save — incrementar quando o formato muda.
  static const int saveVersion = 1;
  // Período de autosave em segundos.
  static const double autosavePeriodo = 30.0;
}
