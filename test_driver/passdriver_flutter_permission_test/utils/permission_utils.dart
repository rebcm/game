import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> checkAudioPermission() async {
    if (await Permission.audio.status.isDenied) {
      await Permission.audio.request();
    }
    return await Permission.audio.status.isGranted;
  }
}
