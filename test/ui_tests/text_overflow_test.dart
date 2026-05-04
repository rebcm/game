import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/test/ui_test_config/device_matrix.dart';

void main() {
  group('Text Overflow Test', () {
    for (var device in DeviceMatrix.devices) {
      testWidgets('Test text overflow on ${device.name}', (tester) async {
        await tester.binding.setSurfaceSize(device.screenSize);
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(TextOverflow.ellipsis), findsNothing);
      });
    }
  });
}
