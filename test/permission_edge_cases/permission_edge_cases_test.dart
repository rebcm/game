import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  test('microphone permission test', () async {
    var status = await Permission.microphone.status;
    expect(status.isGranted, true);
  });
}
