import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Cold Build Test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();
  });
}
