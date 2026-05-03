import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/widget_tracker.dart';
import 'package:game/utils/performance_testing/widget_tracker_impl.dart';

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(MyApp());
    final widgetTracker = WidgetTrackerImpl();
    await widgetTracker.trackRebuilds(() async {
      await tester.tap(find.text('Undo'));
      await tester.pump();
    });
    expect(widgetTracker.rebuildCount, 0);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Undo'),
          ),
        ),
      ),
    );
  }
}
