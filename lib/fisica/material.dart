class Material {
  final String nome;
  final double friccao;
  final double elasticidade;

  Material({required this.nome, required this.friccao, required this.elasticidade});

  factory Material.fromName(String nome) {
    return Material(
      nome: nome,
      friccao: Coeficientes.getFriccao(nome),
      elasticidade: Coeficientes.getElasticidade(nome),
    );
  }
}
