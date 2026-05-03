import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/scenes/3d_scene/3d_scene.dart';

void main() {
  testWidgets('ThreeDScene rebuilds with logger', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ThreeDScene()));
    expect(find.byType(ThreeDScene), findsOneWidget);
    await tester.pump();
    // Additional test logic to verify logger functionality
  });
}
