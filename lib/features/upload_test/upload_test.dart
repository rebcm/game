import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/upload_test/upload_test_screen.dart';

void main() {
  testWidgets('Upload test screen', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UploadTestScreen()));
    expect(find.text('Upload Test'), findsOneWidget);
  });
}
