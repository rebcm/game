import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
      // Implemente aqui a lógica para salvar ou processar a captura de tela
      return true;
    },
  );
}
