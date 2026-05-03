import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/player.dart';
import 'package:mockito/mockito.dart';

class MockAnimationController extends Mock implements AnimationController {}

void main() {
  group('Player', () {
    late Player player;
    late MockAnimationController animationController;

    setUp(() {
      animationController = MockAnimationController();
      player = Player(animationController);
    });

    test('updateTranslationSpeed updates animation controller value', () {
      const translationSpeed = 10.0;
      player.updateTranslationSpeed(translationSpeed);
      verify(animationController.value = 1.0).called(1); // assuming animationSpeed is 10.0
    });
  });
}
