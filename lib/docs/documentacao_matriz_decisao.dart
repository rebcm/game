class DocumentacaoMatrizDecisao {
  static const List<String> criterios = [
    'Custo',
    'Manutenção',
    'UX',
    'Escalabilidade',
  ];

  static const Map<String, Map<String, String>> opcoes = {
    'Markdown': {
      'Custo': 'Baixo',
      'Manutenção': 'Alta',
      'UX': 'Boa',
      'Escalabilidade': 'Média',
    },
    'Tooltips': {
      'Custo': 'Médio',
      'Manutenção': 'Média',
      'UX': 'Boa',
      'Escalabilidade': 'Baixa',
    },
    'Portal Externo': {
      'Custo': 'Alto',
      'Manutenção': 'Baixa',
      'UX': 'Excelente',
      'Escalabilidade': 'Alta',
    },
  };
}

