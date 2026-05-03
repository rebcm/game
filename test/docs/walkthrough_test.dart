import 'package:flutter_test/flutter_test.dart';
import 'package:game/docs/walkthrough.dart';

void main() {
  group('Walkthrough tests', () {
    test('getWalkthroughSteps returns correct steps', () {
      final walkthrough = Walkthrough();
      final steps = walkthrough.getWalkthroughSteps();
      expect(steps, isA<List<String>>());
      expect(steps.length, 3);
    });
  });
}
