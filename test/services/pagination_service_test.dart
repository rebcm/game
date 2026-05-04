import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/pagination_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PaginationService paginationService;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    paginationService = PaginationService(dio);
  });

  test('deve carregar lista paginada com sucesso', () async {
    final response = Response(requestOptions: RequestOptions(path: '/test'), data: {'data': []}, statusCode: 200);
    when(dio.get(any, queryParameters: anyNamed('queryParameters'))).thenAnswer((_) async => response);

    final result = await paginationService.fetchPaginatedList('/test', 1, 10);
    expect(result.statusCode, 200);
  });

  test('deve lançar exceção em caso de falha', () async {
    when(dio.get(any, queryParameters: anyNamed('queryParameters'))).thenThrow(DioException(requestOptions: RequestOptions(path: '/test'), error: 'Erro'));

    expect(() async => await paginationService.fetchPaginatedList('/test', 1, 10), throwsException);
  });
}
