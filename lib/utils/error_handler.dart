class ErrorHandler {
  static Map<String, String> commonErrors = {
    'Could not find or load main class': 'Verifique as variáveis de ambiente.',
    'SocketException: Failed host lookup': 'Verifique a conexão de rede e o serviço de autenticação.',
    'OutOfMemoryError': 'Ajuste as configurações de memória da aplicação.',
  };

  static String? handleError(String errorMessage) {
    return commonErrors[errorMessage];
  }
}

