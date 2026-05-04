import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/permission/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionHandler extends Mock implements Permission {}

void main() {
  late PermissionService permissionService;
  late MockPermissionHandler mockPermissionHandler;

  setUp(() {
    permissionService = PermissionService();
    mockPermissionHandler = MockPermissionHandler();
  });

  group('PermissionService', () {
    test('requestPermission should return true when permission is granted', () async {
      when(() => mockPermissionHandler.request()).thenAnswer((_) async => PermissionStatus.granted);
      final result = await permissionService.requestPermission(mockPermissionHandler);
      expect(result, true);
    });

    test('checkPermission should return true when permission is granted', () async {
      when(() => mockPermissionHandler.status).thenAnswer((_) async => PermissionStatus.granted);
      final result = await permissionService.checkPermission(mockPermissionHandler);
      expect(result, true);
    });
  });
}
