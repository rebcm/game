import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/key_mapping_service/key_mapping_service.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Key Mapping Persistence Test', () {
    testWidgets('should save and load key mapping correctly', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => KeyMappingService()),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                final keyMappingService = context.read<KeyMappingService>();
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await keyMappingService.saveKeyMapping({'jump': 'Space', 'moveForward': 'W'});
                      },
                      child: Text('Save Key Mapping'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await keyMappingService.loadKeyMapping();
                      },
                      child: Text('Load Key Mapping'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Save Key Mapping'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Load Key Mapping'));
      await tester.pumpAndSettle();

      final keyMappingService = tester.firstState<BuilderState>(find.byType(Builder)).context.read<KeyMappingService>();
      expect(keyMappingService.keyMapping, {'jump': 'Space', 'moveForward': 'W'});
    });

    testWidgets('should reset key mapping correctly', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => KeyMappingService()),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                final keyMappingService = context.read<KeyMappingService>();
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await keyMappingService.saveKeyMapping({'jump': 'Space', 'moveForward': 'W'});
                      },
                      child: Text('Save Key Mapping'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await keyMappingService.resetKeyMapping();
                      },
                      child: Text('Reset Key Mapping'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Save Key Mapping'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reset Key Mapping'));
      await tester.pumpAndSettle();

      final keyMappingService = tester.firstState<BuilderState>(find.byType(Builder)).context.read<KeyMappingService>();
      expect(keyMappingService.keyMapping, {});
    });
  });
}
