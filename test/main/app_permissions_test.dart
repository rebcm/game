import 'package:flutter_test/flutter_test.dart';
import 'package:game/main/app_permissions.dart';
import 'package:game/services/permission_service/permission_service.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionService extends Mock implements PermissionService {}

void main() {
  group('AppPermissions', () {
    late AppPermissions appPermissions;
    late MockPermissionService permissionService;

    setUp(() {
      permissionService = MockPermissionService();
      appPermissions = AppPermissions(permissionService);
    });

    test('requestNecessaryPermissions calls requestPermission for necessary permissions', () async {
      when(() => permissionService.requestPermission(Permission.storage)).thenAnswer((_) async => true);
      await appPermissions.requestNecessaryPermissions();
      verify(() => permissionService.requestPermission(Permission.storage)).called(1);
    });

    test('checkNecessaryPermissions throws exception when necessary permission is not granted', () async {
      when(() => permissionService.checkPermission(Permission.storage)).thenAnswer((_) async => false);
      expect(() async => await appPermissions.checkNecessaryPermissions(), throwsException);
    });
  });
}
