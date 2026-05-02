import 'package:flutter_test/flutter_test.dart';
import 'package:game/mundo/gerador.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verifica geração de chunk', (tester) async {
    final chunk = GeradorMundo.gerarChunk(0, 0);
    expect(chunk.blocos.length, greaterThan(0));
    expect(chunk.blocos[0].tipo, isNotNull);
  });
}
