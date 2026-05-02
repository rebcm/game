class Coeficientes {
  static const double friccaoBlocoTerra = 0.6;
  static const double friccaoBlocoPedra = 0.8;
  static const double friccaoBlocoMadeira = 0.5;
  static const double friccaoRebeca = 0.4;

  static const double elasticidadeBlocoTerra = 0.2;
  static const double elasticidadeBlocoPedra = 0.1;
  static const double elasticidadeBlocoMadeira = 0.3;
  static const double elasticidadeRebeca = 0.4;

  static double getFriccao(String material) {
    switch (material) {
      case 'blocoTerra':
        return friccaoBlocoTerra;
      case 'blocoPedra':
        return friccaoBlocoPedra;
      case 'blocoMadeira':
        return friccaoBlocoMadeira;
      case 'rebeca':
        return friccaoRebeca;
      default:
        throw ArgumentError('Material não suportado');
    }
  }

  static double getElasticidade(String material) {
    switch (material) {
      case 'blocoTerra':
        return elasticidadeBlocoTerra;
      case 'blocoPedra':
        return elasticidadeBlocoPedra;
      case 'blocoMadeira':
        return elasticidadeBlocoMadeira;
      case 'rebeca':
        return elasticidadeRebeca;
      default:
        throw ArgumentError('Material não suportado');
    }
  }
}
