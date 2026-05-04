import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/logging/package_log.dart';

void main() {
  test('PackageLog serialization', () {
    final log = PackageLog(id: 1, status: 'received', timestamp: DateTime.now());
    final json = log.toJson();
    final deserializedLog = PackageLog.fromJson(json);
    expect(deserializedLog.id, log.id);
    expect(deserializedLog.status, log.status);
  });
}
