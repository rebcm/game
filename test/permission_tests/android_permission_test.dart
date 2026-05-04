import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  test('Testar permissão de áudio/mídia no Android 13+', () async {
    final status = await Permission.audio.status;
    expect(status.isGranted, true);
  });
}
