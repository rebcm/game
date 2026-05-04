import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/permission_service/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  group('PermissionService', () {
    late PermissionService permissionService;

    setUp(() {
      permissionService = PermissionService();
    });

    test('requestPermission returns true when permission is granted', () async {
      final result = await permissionService.requestPermission(Permission.storage);
      expect(result, true);
    });

    test('checkPermission returns true when permission is granted', () async {
      await permissionService.requestPermission(Permission.storage);
      final result = await permissionService.checkPermission(Permission.storage);
      expect(result, true);
    });
  });
}
