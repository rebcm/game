import 'package:flutter_test/flutter_test.dart';
import 'package:game/version_service.dart';

void main() {
  test('should throw error on build version conflict', () async {
    expect(() async => await VersionService.checkVersion('invalid_version'), throwsA(isA<VersionConflictException>()));
  });
}

class VersionConflictException implements Exception {}
