import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/artefato_service.dart';

void main() {
  testWidgets('verificação de integridade pós-limpeza', (tester) async {
    // Arrange
    final artefatoService = ArtefatoService();
    await artefatoService.inicializar();

    // Act
    await artefatoService.limparArtefatos();

    // Assert
    expect(await artefatoService.verificarIntegridadePosLimpeza(), true);
  });
}
