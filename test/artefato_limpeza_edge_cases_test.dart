import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/artefato_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Artefato Limpeza Edge Cases Test', () {
    late ArtefatoService artefatoService;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      artefatoService = ArtefatoService(mockHttpClient);
    });

    test('preserva versões de release', () async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/artefatos')))
          .thenAnswer((_) async => http.Response('[]', 200));

      await artefatoService.limparArtefatos();

      verify(() => mockHttpClient.get(Uri.parse('https://example.com/artefatos'))).called(1);
    });

    test('comportamento em caso de falha na API do servidor de artefatos', () async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/artefatos')))
          .thenAnswer((_) async => http.Response('Erro', 500));

      expect(() async => await artefatoService.limparArtefatos(), throwsException);
    });

    test('verificação de integridade pós-limpeza', () async {
      when(() => mockHttpClient.get(Uri.parse('https://example.com/artefatos')))
          .thenAnswer((_) async => http.Response('[]', 200));

      await artefatoService.limparArtefatos();

      expect(artefatoService.listaArtefatos, isEmpty);
    });
  });
}
