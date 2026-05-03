import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/test/ui_test_config/device_matrix.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UI Validation Tests', () {
    for (var device in DeviceMatrix.devices) {
      testWidgets('Validate UI on ${device.name}', (tester) async {
        await tester.binding.setSurfaceSize(device.screenSize);
        tester.binding.window.devicePixelRatioTestProperty = device.devicePixelRatio;
        tester.binding.window.textScaleFactorTestProperty = device.textScaleFactor;

        await tester.pumpWidget(app.MyApp());

        await tester.pumpAndSettle();

        // Add UI validation logic here
        expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
      });
    }
  });
}
