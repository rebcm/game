import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/persistencia/repositorio.dart';
import 'package:rebcm/persistencia/datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockDatasource extends Mock implements Datasource {}

void main() {
  late Repositorio repositorio;
  late MockDatasource datasource;

  setUp(() {
    datasource = MockDatasource();
    repositorio = Repositorio(datasource);
  });

  test('Deve garantir consistência atômica em operações', () async {
    when(() => datasource.salvarD1(any())).thenAnswer((_) async {});
    when(() => datasource.salvarR2(any())).thenThrow(Exception('Falha simulada'));

    expect(() async => await repositorio.inserirDados('dados'), throwsException);

    verifyNever(() => datasource.salvarD1(any()));
    verifyNever(() => datasource.salvarR2(any()));
  });

  test('Deve realizar rollback corretamente', () async {
    when(() => datasource.salvarD1(any())).thenAnswer((_) async {});
    when(() => datasource.salvarR2(any())).thenThrow(Exception('Falha simulada'));

    try {
      await repositorio.inserirDados('dados');
    } catch (_) {}

    verify(() => datasource.limparD1()).called(1);
  });
}
