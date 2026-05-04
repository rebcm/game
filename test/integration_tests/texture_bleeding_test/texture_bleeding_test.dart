import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Texture bleeding test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Verify that the texture bleeding is not occurring
    final Finder voxelBlock = find.byKey(const Key('voxel_block'));
    expect(voxelBlock, findsOneWidget);

    final Image voxelImage = tester.widget(voxelBlock);
    expect(voxelImage.filterQuality, FilterQuality.none);
  });
}
