import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'helpers/gc_forcer.dart';

void main() {
  testWidgets('Memory test with GC forcing', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    GCForcer.forceGC();

    // Perform memory measurements or leak detection here
  });
}
