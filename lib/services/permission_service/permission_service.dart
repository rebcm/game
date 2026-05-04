import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestAudioPermission() async {
    final status = await Permission.audio.status;
    if (status.isDenied) {
      final result = await Permission.audio.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  Future<bool> checkAudioPermission() async {
    final status = await Permission.audio.status;
    return status.isGranted;
  }
}
