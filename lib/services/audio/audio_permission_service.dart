import 'package:permission_handler/permission_handler.dart';

class AudioPermissionService {
  Future<bool> requestAudioPermission() async {
    final status = await Permission.audio.status;
    if (status.isDenied) {
      final result = await Permission.audio.request();
      return result.isGranted;
    }
    return status.isGranted;
  }
}
