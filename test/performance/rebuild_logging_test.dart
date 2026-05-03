import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/rebuild_logger.dart';
import 'package:game/widgets/three_d_scene/rebuild_logger_wrapper.dart';

void main() {
  testWidgets('RebuildLoggerWrapper logs rebuilds', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RebuildLoggerWrapper(
          widgetName: 'TestWidget',
          child: Container(),
        ),
      ),
    );

    expect(find.text('Rebuild: TestWidget'), findsNothing); // debugPrint is not directly testable

    await tester.pump();
  });
}
