import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/build_service.dart';

void main() {
  test('Build version conflict test', () async {
    // Simulate build version conflict
    final buildService = BuildService();
    final isValid = await buildService.isValidBuildVersion('1.0.0+1');
    expect(isValid, false);
  });
}
