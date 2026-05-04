import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/context_menu/context_menu.dart';

void main() {
  group('ContextMenu', () {
    testWidgets('showContextMenu shows a menu', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            final contextMenu = ContextMenu(context);
            contextMenu.showContextMenu(Offset(100, 100));
            return Container();
          },
        ),
      ));
      await tester.pump();
      expect(find.text('Menu Item 1'), findsOneWidget);
      expect(find.text('Menu Item 2'), findsOneWidget);
    });

    testWidgets('hideContextMenu hides the menu', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) {
            final contextMenu = ContextMenu(context);
            contextMenu.showContextMenu(Offset(100, 100));
            return Container();
          },
        ),
      ));
      await tester.pump();
      final context = tester.element(find.byType(MaterialApp));
      final contextMenu = ContextMenu(context);
      contextMenu.hideContextMenu();
      await tester.pump();
      expect(find.text('Menu Item 1'), findsNothing);
      expect(find.text('Menu Item 2'), findsNothing);
    });
  });
}
