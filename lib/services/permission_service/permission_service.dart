import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.status;
    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}
