import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/ride/widgets/ride_animation.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride/providers/ride_provider.dart';

void main() {
  testWidgets('Ride animation stress test', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => RideProvider(),
        child: RideAnimation(),
      ),
    );

    final rideProvider = tester.state<RideProvider>(find.byType(ChangeNotifierProvider)).read<RideProvider>();

    for (int i = 0; i < 100; i++) {
      rideProvider.updateSpeed(0);
      await tester.pump();
      rideProvider.updateSpeed(100);
      await tester.pump();
      expect(find.byType(RideAnimation), findsOneWidget);
    }
  });
}
