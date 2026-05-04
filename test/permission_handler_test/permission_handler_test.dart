import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:game/services/permission_service.dart';

void main() {
  group('PermissionService', () {
    test('should handle permanent denial of permission', () async {
      // Mock permanent denial
      when(() => Permission.microphone.request()).thenAnswer((_) async => PermissionStatus.permanentlyDenied);
      final result = await PermissionService.requestMicrophonePermission();
      expect(result, false);
    });

    test('should handle device without microphone hardware', () async {
      // Mock device without microphone
      when(() => Permission.microphone.request()).thenAnswer((_) async => PermissionStatus.denied);
      final result = await PermissionService.requestMicrophonePermission();
      expect(result, false);
    });

    test('should handle permission revocation while app is open', () async {
      // Mock permission revocation
      when(() => Permission.microphone.status).thenAnswer((_) async => PermissionStatus.granted);
      await PermissionService.requestMicrophonePermission();
      when(() => Permission.microphone.status).thenAnswer((_) async => PermissionStatus.denied);
      final result = await PermissionService.checkMicrophonePermission();
      expect(result, false);
    });
  });
}
