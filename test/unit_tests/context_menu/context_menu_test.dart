import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/context_menu/context_menu.dart';

void main() {
  group('ContextMenu', () {
    testWidgets('showContextMenu and hideContextMenu work correctly', (tester) async {
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
      expect(find.byType(PopupMenu), findsOneWidget);
      final contextMenu = ContextMenu(tester.element(find.byType(Builder)));
      contextMenu.hideContextMenu();
      await tester.pump();
      expect(find.byType(PopupMenu), findsNothing);
    });
  });
}
