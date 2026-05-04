class HttpResponseMatrix {
  static const Map<String, Map<int, String>> responseMatrix = {
    '/api/exemplo': {
      200: '{ "mensagem": "Sucesso" }',
      400: '{ "erro": "Requisição inválida" }',
      401: '{ "erro": "Não autorizado" }',
      500: '{ "erro": "Erro interno do servidor" }',
    },
  };
}
