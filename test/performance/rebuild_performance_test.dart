import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/widgets/three_d_scene/three_d_scene.dart';

void main() {
  testWidgets('ThreeDScene rebuild test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ThreeDScene()));
    // Test rebuild logic here
  });
}
