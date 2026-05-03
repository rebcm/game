import 'package:flutter_test/flutter_test.dart';
import 'package:game/docs/walkthrough.dart';
import 'package:game/services/walkthrough/walkthrough_service.dart';

void main() {
  group('WalkthroughService tests', () {
    test('getWalkthroughSteps returns correct steps', () {
      final walkthrough = Walkthrough();
      final walkthroughService = WalkthroughService(walkthrough);
      final steps = walkthroughService.getWalkthroughSteps();
      expect(steps, isA<List<String>>());
      expect(steps.length, 3);
    });
  });
}
