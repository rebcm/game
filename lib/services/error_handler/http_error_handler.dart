import 'package:http/http.dart' as http;

class HttpErrorHandler {
  static String handleHttpError(http.Response response) {
    switch (response.statusCode) {
      case 401:
        return 'Não autorizado. Verifique suas credenciais.';
      case 403:
        return 'Acesso proibido. Verifique suas permissões.';
      case 507:
        return 'Armazenamento insuficiente. Contate o suporte.';
      default:
        return 'Erro desconhecido. Código: ${response.statusCode}';
    }
  }
}

