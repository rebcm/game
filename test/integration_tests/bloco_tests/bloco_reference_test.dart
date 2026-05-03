import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/bloco/bloco.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate bloco reference matrix', (tester) async {
    final List<Bloco> blocos = Bloco.values.toList();
    expect(blocos, isNotEmpty);
  });
}
