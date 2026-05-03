import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Rebuild monitoring test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    final rebuildLogger = RebuildLogger();
    await tester.pumpWidget(RebuildLoggerWidget(rebuildLogger, child: app.MyApp()));
    await tester.pumpAndSettle();

    expect(rebuildLogger.rebuildCount, lessThan(10));
  });
}

class RebuildLogger with ChangeNotifier {
  int _rebuildCount = 0;

  int get rebuildCount => _rebuildCount;

  void logRebuild() {
    _rebuildCount++;
    notifyListeners();
  }
}

class RebuildLoggerWidget extends StatefulWidget {
  final RebuildLogger rebuildLogger;
  final Widget child;

  RebuildLoggerWidget(this.rebuildLogger, {required this.child});

  @override
  _RebuildLoggerWidgetState createState() => _RebuildLoggerWidgetState();
}

class _RebuildLoggerWidgetState extends State<RebuildLoggerWidget> {
  @override
  void initState() {
    super.initState();
    widget.rebuildLogger.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.rebuildLogger.logRebuild();
    return widget.child;
  }
}
