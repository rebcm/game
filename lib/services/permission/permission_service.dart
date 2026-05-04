import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}
