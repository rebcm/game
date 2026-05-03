import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/widget_tracker_impl.dart';

void main() {
  testWidgets('rebuild performance test', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    final widgetTracker = WidgetTrackerImpl();
    await widgetTracker.init();

    for (int i = 0; i < 100; i++) {
      await tester.tap(find.byKey(Key('undo_redo_button')));
      await tester.pump();
    }

    final rebuildCount = await widgetTracker.getRebuildCount();
    expect(rebuildCount, lessThan(150));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            key: Key('undo_redo_button'),
            onPressed: () {},
            child: Text('Undo/Redo'),
          ),
        ),
      ),
    );
  }
}
