import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/test/ui_test_config/device_matrix.dart';

void main() {
  group('UI Tests', () {
    for (var device in DeviceMatrix.devices) {
      testWidgets('Test UI on ${device.name}', (tester) async {
        await tester.binding.setSurfaceSize(device.screenSize);
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: device.textScaleFactor,
                  ),
                  child: app.MyApp(),
                );
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
        await expectLater(find.byType(app.MyApp), matchesGoldenFile('ui_test_${device.name}.png'));
      });
    }
  });
}
