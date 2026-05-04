import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/permission_service/permission_service.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

class MockPermissionHandler extends Mock implements Permission {}

void main() {
  group('PermissionService', () {
    late PermissionService permissionService;
    late MockPermissionHandler mockPermissionHandler;

    setUp(() {
      permissionService = PermissionService();
      mockPermissionHandler = MockPermissionHandler();
      when(Permission.audio.status).thenAnswer((_) async => PermissionStatus.denied);
      when(Permission.audio.request()).thenAnswer((_) async => PermissionStatus.granted);
    });

    test('should request audio permission when status is denied', () async {
      when(Permission.audio.status).thenAnswer((_) async => PermissionStatus.denied);
      final result = await permissionService.requestAudioPermission();
      expect(result, true);
      verify(Permission.audio.request()).called(1);
    });

    test('should not request audio permission when status is granted', () async {
      when(Permission.audio.status).thenAnswer((_) async => PermissionStatus.granted);
      final result = await permissionService.requestAudioPermission();
      expect(result, true);
      verifyNever(Permission.audio.request());
    });

    test('should check audio permission status', () async {
      when(Permission.audio.status).thenAnswer((_) async => PermissionStatus.granted);
      final result = await permissionService.checkAudioPermission();
      expect(result, true);
    });
  });
}
