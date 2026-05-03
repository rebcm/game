import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/performance_testing/widget_tracker_impl.dart';

void main() {
  testWidgets('Rebuild performance test', (tester) async {
    await tester.pumpWidget(MyApp());
    final widgetTracker = WidgetTrackerImpl();

    // Initialize the widget tracker
    await widgetTracker.init();

    // Perform an undo operation
    await tester.tap(find.byKey(Key('undo_button')));

    // Wait for the rebuilds to settle
    await tester.pumpAndSettle();

    // Get the rebuild count for unaffected widgets
    final rebuildCount = widgetTracker.getRebuildCount();

    // Assert that the rebuild count is zero
    expect(rebuildCount, 0);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: Key('undo_button'),
        onPressed: () {
          // Perform an undo operation
        },
        child: Text('Undo'),
      ),
    );
  }
}
