import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/artefato_service.dart';

void main() {
  testWidgets('preservacao de versões de release', (tester) async {
    // Arrange
    final artefatoService = ArtefatoService();
    await artefatoService.inicializar();

    // Act
    await artefatoService.limparArtefatos();

    // Assert
    expect(await artefatoService.verificarPreservacaoVersoesRelease(), true);
  });
}
