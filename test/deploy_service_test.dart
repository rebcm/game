import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/deploy_service.dart';

void main() {
  test('deploy service test', () async {
    final deployService = DeployService();
    await deployService.deploy();
    // Implement test logic here
  });
}
