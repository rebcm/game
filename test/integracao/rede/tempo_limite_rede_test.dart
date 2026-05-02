import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/config/constantes.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Testes de timeout de rede', () {
    late http.Client client;

    setUp(() {
      client = MockHttpClient();
    });

    test('Verifica timeout ao chamar API da Cloudflare', () async {
      when(() => client.get(Uri.parse(Constantes.urlApiCloudflare)))
          .thenAnswer((_) async => http.Response('Timeout', 408));

      final response = await client.get(Uri.parse(Constantes.urlApiCloudflare))
          .timeout(Duration(seconds: Constantes.tempoLimiteRequisicao));

      expect(response.statusCode, 408);
    });

    test('Lança exceção ao exceder tempo limite', () async {
      when(() => client.get(Uri.parse(Constantes.urlApiCloudflare)))
          .thenAnswer((_) async => Future.delayed(Duration(seconds: Constantes.tempoLimiteRequisicao + 1)));

      expect(() async => await client.get(Uri.parse(Constantes.urlApiCloudflare))
          .timeout(Duration(seconds: Constantes.tempoLimiteRequisicao)),
          throwsA(isA<TimeoutException>()));
    });
  });
}
