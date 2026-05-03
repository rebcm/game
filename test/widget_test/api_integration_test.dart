import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/mock_api/mock_api.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('API integration test', (WidgetTester tester) async {
    // Implement API integration test here
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
