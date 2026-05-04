import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/permission/permission_service.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionService extends Mock implements PermissionService {}

void main() {
  late MockPermissionService mockPermissionService;

  setUp(() {
    mockPermissionService = MockPermissionService();
  });

  testWidgets('should show error when permission is permanently denied', (tester) async {
    when(() => mockPermissionService.requestPermission()).thenAnswer((_) async => PermissionStatus.permanentlyDenied);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PermissionWidget(permissionService: mockPermissionService),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Permissão negada permanentemente'), findsOneWidget);
  });

  testWidgets('should show error when device does not have microphone hardware', (tester) async {
    when(() => mockPermissionService.requestPermission()).thenAnswer((_) async => PermissionStatus.restricted);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PermissionWidget(permissionService: mockPermissionService),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dispositivo não possui hardware de microfone'), findsOneWidget);
  });

  testWidgets('should show error when permission is revoked while app is open', (tester) async {
    when(() => mockPermissionService.requestPermission()).thenAnswer((_) async => PermissionStatus.denied);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PermissionWidget(permissionService: mockPermissionService),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Permissão revogada'), findsOneWidget);
  });
}
