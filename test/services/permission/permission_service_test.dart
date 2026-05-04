import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/permission/permission_service.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

class MockPermissionHandler extends Mock implements Permission {}

void main() {
  group('PermissionService', () {
    late PermissionService service;
    late MockPermissionHandler mockPermissionHandler;

    setUp(() {
      mockPermissionHandler = MockPermissionHandler();
      service = PermissionService();
    });

    test('should request audio permission', () async {
      when(mockPermissionHandler.status).thenAnswer((_) async => PermissionStatus.denied);
      when(mockPermissionHandler.request()).thenAnswer((_) async => PermissionStatus.granted);

      final result = await service.requestAudioPermission();

      expect(result, true);
      verify(mockPermissionHandler.status).called(1);
      verify(mockPermissionHandler.request()).called(1);
    });

    test('should check audio permission', () async {
      when(mockPermissionHandler.status).thenAnswer((_) async => PermissionStatus.granted);

      final result = await service.checkAudioPermission();

      expect(result, true);
      verify(mockPermissionHandler.status).called(1);
    });
  });
}
