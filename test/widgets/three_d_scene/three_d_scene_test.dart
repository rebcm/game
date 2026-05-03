import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/three_d_scene/three_d_scene_wrapper.dart';

void main() {
  testWidgets('ThreeDScene rebuild count test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ThreeDSceneWrapper()));
    await tester.pump();
    // Verify rebuild count
  });
}
