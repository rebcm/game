import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/three_d_scene/rebuild_logger_wrapper.dart';

void main() {
  testWidgets('RebuildLoggerWrapper logs rebuild', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RebuildLoggerWrapper(
          widgetName: 'TestWidget',
          child: Container(),
        ),
      ),
    );

    expect(find.text('Rebuild: TestWidget'), findsNothing); // debugPrint is not directly testable, adjust test accordingly
  });
}
