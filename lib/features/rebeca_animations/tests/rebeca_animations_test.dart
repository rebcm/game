import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/rebeca_animations/rebeca_animations.dart';

void main() {
  group('RebecaAnimations', () {
    late RebecaAnimations rebecaAnimations;

    setUp(() {
      rebecaAnimations = RebecaAnimations();
    });

    test('initAnimation initializes animation controller', () {
      TestWidget testWidget = TestWidget(rebecaAnimations: rebecaAnimations);
      expect(rebecaAnimations._animationController, isNull);
      tester.pumpWidget(testWidget);
      expect(rebecaAnimations._animationController, isNotNull);
    });

    test('getAnimation returns animation', () {
      TestWidget testWidget = TestWidget(rebecaAnimations: rebecaAnimations);
      tester.pumpWidget(testWidget);
      expect(rebecaAnimations.getAnimation(), isA<Animation<double>>());
    });

    test('dispose disposes animation controller', () {
      TestWidget testWidget = TestWidget(rebecaAnimations: rebecaAnimations);
      tester.pumpWidget(testWidget);
      expect(rebecaAnimations._animationController!.isDisposed, isFalse);
      rebecaAnimations.dispose();
      expect(rebecaAnimations._animationController!.isDisposed, isTrue);
    });
  });
}

class TestWidget extends StatefulWidget {
  final RebecaAnimations rebecaAnimations;

  TestWidget({required this.rebecaAnimations});

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.rebecaAnimations.initAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
