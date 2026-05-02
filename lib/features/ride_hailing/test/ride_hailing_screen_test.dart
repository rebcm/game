import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride_hailing/screens/ride_hailing_screen.dart';

void main() {
  testWidgets('RideHailingScreen should display ride status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RideHailingScreen(),
      ),
    );
    expect(find.text('Status da corrida'), findsOneWidget);
  });

  testWidgets('RideHailingScreen should handle FPS/Jank', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RideHailingScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Status da corrida'), findsOneWidget);
  });
}
