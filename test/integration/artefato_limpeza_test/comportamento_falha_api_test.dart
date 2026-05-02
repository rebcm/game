import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/artefato_service.dart';

void main() {
  testWidgets('comportamento em caso de falha na API', (tester) async {
    // Arrange
    final artefatoService = ArtefatoService();
    await artefatoService.inicializar();

    // Act e Assert
    expect(() async => await artefatoService.limparArtefatosComFalhaApi(), throwsException);
  });
}
