import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/animated/optimized_animation.dart';

void main() {
  testWidgets('OptimizedAnimation widget test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: OptimizedAnimation()));
    expect(find.byType(OptimizedAnimation), findsOneWidget);
  });
}
