import 'package:game/services/permission_service.dart';

class PermissionUtils {
  static final PermissionService _permissionService = PermissionService();

  static Future<bool> requestStoragePermission() async {
    return await _permissionService.requestStoragePermission();
  }

  static Future<bool> checkStoragePermission() async {
    return await _permissionService.checkStoragePermission();
  }
}
