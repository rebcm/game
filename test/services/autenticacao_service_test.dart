import 'package:test/test.dart';
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/services/autenticacao_service.dart';

void main() {
  group('AutenticacaoService', () {
    test('validarIdentidadeUsuario retorna true para usuário válido', () async {
      final httpMock = HttpMock();
      httpMock.onGet('https://construcao-criativa.workers.dev/api/usuarios/usuario-valido').returnWith(200, '');
      final service = AutenticacaoService();
      expect(await service.validarIdentidadeUsuario('usuario-valido'), isTrue);
    });

    test('obterLimiteMundos retorna limite correto', () async {
      final httpMock = HttpMock();
      httpMock.onGet('https://construcao-criativa.workers.dev/api/usuarios/usuario-valido/limite-mundos').returnWith(200, '5');
      final service = AutenticacaoService();
      expect(await service.obterLimiteMundos('usuario-valido'), 5);
    });
  });
}
