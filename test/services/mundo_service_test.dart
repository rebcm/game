import 'package:test/test.dart';
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/services/mundo_service.dart';
import 'package:rebcm/services/autenticacao_service.dart';
import 'package:rebcm/models/mundo.dart';

void main() {
  group('MundoService', () {
    test('criarMundo retorna false para usuário inválido', () async {
      final autenticacaoService = AutenticacaoService();
      final httpMock = HttpMock();
      httpMock.onGet('https://construcao-criativa.workers.dev/api/usuarios/usuario-invalido').returnWith(404, '');
      final service = MundoService(autenticacaoService);
      final mundo = Mundo(id: 'mundo-id', usuarioId: 'usuario-invalido');
      expect(await service.criarMundo(mundo), isFalse);
    });

    test('criarMundo retorna false quando limite de mundos é atingido', () async {
      final autenticacaoService = AutenticacaoService();
      final httpMock = HttpMock();
      httpMock.onGet('https://construcao-criativa.workers.dev/api/usuarios/usuario-valido').returnWith(200, '');
      httpMock.onGet('https://construcao-criativa.workers.dev/api/usuarios/usuario-valido/limite-mundos').returnWith(200, '1');
      httpMock.onGet('https://construcao-criativa.workers.dev/api/usuarios/usuario-valido/mundos').returnWith(200, '[{"id": "mundo-existente", "usuarioId": "usuario-valido"}]');
      final service = MundoService(autenticacaoService);
      final mundo = Mundo(id: 'novo-mundo-id', usuarioId: 'usuario-valido');
      expect(await service.criarMundo(mundo), isFalse);
    });
  });
}
