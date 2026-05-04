import 'package:game/services/permission_service/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  final PermissionService _permissionService;

  AppPermissions(this._permissionService);

  Future<void> requestNecessaryPermissions() async {
    await _permissionService.requestPermission(Permission.storage);
    // Add other necessary permissions here
  }

  Future<void> checkNecessaryPermissions() async {
    final storagePermission = await _permissionService.checkPermission(Permission.storage);
    if (!storagePermission) {
      throw Exception('Storage permission is required');
    }
    // Add checks for other necessary permissions here
  }
}
