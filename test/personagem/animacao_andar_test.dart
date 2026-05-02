import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rebcm/personagem/animacao_andar.dart';
import 'package:rebcm/personagem/rebeca.dart';

class MockRebeca extends Mock implements Rebeca {}

void main() {
  late AnimacaoAndar animacaoAndar;
  late MockRebeca rebeca;

  setUp(() {
    rebeca = MockRebeca();
    animacaoAndar = AnimacaoAndar(rebeca);
  });

  test('atualizar deve iniciar animação quando Rebeca está andando', () {
    when(rebeca.estaAndando).thenReturn(true);
    animacaoAndar.atualizar();
    verify(rebeca.animacaoController.forward(from: 0)).called(1);
  });

  test('atualizar deve parar animação quando Rebeca não está andando', () {
    when(rebeca.estaAndando).thenReturn(false);
    animacaoAndar.atualizar();
    verify(rebeca.animacaoController.stop()).called(1);
  });

  test('estaSincronizada deve retornar true quando braço e perna estão sincronizados', () {
    when(rebeca.bracoAnimacao.value).thenReturn(0.5);
    when(rebeca.pernaAnimacao.value).thenReturn(0.5);
    expect(animacaoAndar.estaSincronizada, true);
  });

  test('atendeFpsMinimo deve retornar true quando FPS atende ao mínimo', () {
    when(rebeca.animacaoController.lastElapsedDuration).thenReturn(const Duration(milliseconds: 42)); // ~24 FPS
    expect(animacaoAndar.atendeFpsMinimo, true);
  });
}
