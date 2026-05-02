import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/error_handler/http_error_handler.dart';

void main() {
  group('HttpErrorHandler', () {
    test('deve retornar a mensagem de erro correta para 401', () {
      final response = http.Response('Not Authorized', 401);
      expect(HttpErrorHandler.handleHttpError(response), 'Não autorizado. Verifique suas credenciais.');
    });

    test('deve retornar a mensagem de erro correta para 403', () {
      final response = http.Response('Forbidden', 403);
      expect(HttpErrorHandler.handleHttpError(response), 'Acesso proibido. Verifique suas permissões.');
    });

    test('deve retornar a mensagem de erro correta para 507', () {
      final response = http.Response('Insufficient Storage', 507);
      expect(HttpErrorHandler.handleHttpError(response), 'Armazenamento insuficiente. Contate o suporte.');
    });

    test('deve retornar a mensagem de erro desconhecido para outros códigos', () {
      final response = http.Response('Unknown Error', 500);
      expect(HttpErrorHandler.handleHttpError(response), 'Erro desconhecido. Código: 500');
    });
  });
}

