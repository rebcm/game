import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/passdriver/ui/content_integration_ui.dart';
import 'package:provider/provider.dart';
import 'package:game/passdriver/integration_plan/content_integration_plan.dart';

void main() {
  testWidgets('ContentIntegrationUI displays dropdown and button', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ContentIntegrationPlan()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: ContentIntegrationUI(),
          ),
        ),
      ),
    );

    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
