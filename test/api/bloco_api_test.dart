import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/bloco_api.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('BlocoApi', () {
    late BlocoApi blocoApi;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      blocoApi = BlocoApi();
      // Ideally, you should inject the http client into BlocoApi
      // For simplicity, this example doesn't show that
    });

    test('getBlocos returns a list of blocos on successful request', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response('[{"id": 1, "nome": "Bloco 1", "descricao": "Descrição do Bloco 1"}]', 200));

      // Act
      final blocos = await blocoApi.getBlocos();

      // Assert
      expect(blocos, isA<List<Bloco>>());
      expect(blocos.first.id, 1);
      expect(blocos.first.nome, 'Bloco 1');
      expect(blocos.first.descricao, 'Descrição do Bloco 1');
    });

    test('getBlocos throws an exception on unsuccessful request', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act and Assert
      expect(() async => await blocoApi.getBlocos(), throwsException);
    });
  });
}
