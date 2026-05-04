import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/autenticacao_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AutenticacaoService service;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    service = AutenticacaoService(dio);
  });

  group('AutenticacaoService', () {
    test('login bem-sucedido', () async {
      when(dio.post('/auth/login', data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: {'token': 'token-test'},
                statusCode: 200,
                requestOptions: RequestOptions(path: '/auth/login'),
              ));

      final token = await service.login('user', 'pass');
      expect(token, 'token-test');
    });

    test('login falha', () async {
      when(dio.post('/auth/login', data: anyNamed('data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/auth/login'), error: 'Erro'));

      final token = await service.login('user', 'pass');
      expect(token, isNull);
    });
  });
}
