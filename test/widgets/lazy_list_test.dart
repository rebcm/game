import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/lazy_list.dart';

void main() {
  testWidgets('LazyList displays items', (tester) async {
    final items = List.generate(10, (index) => 'Item $index');
    await tester.pumpWidget(MaterialApp(home: LazyList(items: items)));
    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 9'), findsOneWidget);
  });
}
