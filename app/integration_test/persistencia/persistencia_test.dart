import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:construcao_criativa/servicos/persistencia.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Persistência de Dados', () {
    testWidgets('Verifica se os valores salvos são carregados corretamente', (tester) async {
      SharedPreferences.setMockInitialValues({});
      await Persistencia.inicializar();
      
      await Persistencia.salvarValor('teste', 'valor_teste');
      await tester.pumpAndSettle();

      await Persistencia.carregarValores();
      await tester.pumpAndSettle();

      expect(Persistencia.obterValor('teste'), 'valor_teste');
    });

    testWidgets('Verifica se a inicialização não causa delays na inicialização do motor de áudio', (tester) async {
      SharedPreferences.setMockInitialValues({});
      Stopwatch stopwatch = Stopwatch()..start();
      
      await Persistencia.inicializar();
      await tester.pumpAndSettle();

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(500));
    });
  });
}
