import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/utils/version_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flutter e Dart version check', (tester) async {
    VersionUtils.checkFlutterVersion();
    VersionUtils.checkDartVersion();
    // Adicione asserts ou lógica para validar o comportamento esperado
  });
}
