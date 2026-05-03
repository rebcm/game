import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/resolution_matrix.dart';

void main() {
  group('Dicas UI Test', () {
    testWidgets('should not overflow text on different resolutions', (tester) async {
      for (var size in ResolutionMatrix.getResolutions()) {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(MyApp());

        expect(find.byType(OverflowError), findsNothing);
      }
    });

    testWidgets('should not overflow text on different breakpoints', (tester) async {
      for (var size in ResolutionMatrix.getBreakpointSizes()) {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(MyApp());

        expect(find.byType(OverflowError), findsNothing);
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DicasScreen(), // Assuming DicasScreen is the widget to test
      ),
    );
  }
}
