import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/api_testing/presentation/api_testing_screen.dart';

void main() {
  testWidgets('API Testing Screen', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ApiTestingScreen()));
    expect(find.text('API Testing'), findsOneWidget);
  });
}
