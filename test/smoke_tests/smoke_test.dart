import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  group('Smoke Tests', () {
    testWidgets('Inicialização do jogo sem erros', (tester) async {
      await tester.pumpWidget(app.MyApp());
      expect(find.text('Rebeca\'s World'), findsOneWidget);
    });

    testWidgets('Renderização correta do mundo voxel', (tester) async {
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(CustomVoxelWorldWidget), findsOneWidget);
    });

    testWidgets('Funcionalidade de construção de blocos', (tester) async {
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.byType(BlockBuilderWidget), findsOneWidget);
    });

    testWidgets('Navegação básica pelo mundo', (tester) async {
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();
      await tester.drag(find.byType(CustomVoxelWorldWidget), Offset(100, 0));
      await tester.pumpAndSettle();
      expect(find.byType(CustomVoxelWorldWidget), findsOneWidget);
    });

    testWidgets('Áudio funcionando corretamente', (tester) async {
      await tester.pumpWidget(app.MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(AudioPlayerWidget), findsOneWidget);
    });
  });
}
