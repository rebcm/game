import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/endpoint_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late EndpointService service;

  setUp(() {
    client = MockHttpClient();
    service = EndpointService(client);
  });

  test('não deve aceitar nomes duplicados', () async {
    when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
      .thenAnswer((_) async => http.Response('{"error": "Nome já existe"}', 400));

    final response = await service.criarNome('nomeExistente');

    expect(response.statusCode, 400);
    verify(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).called(1);
  });

  test('deve criar nome único', () async {
    when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
      .thenAnswer((_) async => http.Response('{"message": "Nome criado"}', 201));

    final response = await service.criarNome('nomeUnico');

    expect(response.statusCode, 201);
    verify(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).called(1);
  });
}
