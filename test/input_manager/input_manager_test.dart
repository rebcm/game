import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/input_manager/input_manager.dart';
import 'package:game/control_schemes/default_control_scheme.dart';
import 'package:game/control_schemes/alternative_control_scheme.dart';

void main() {
  test('InputManager switches control scheme correctly', () {
    final defaultScheme = DefaultControlScheme();
    final alternativeScheme = AlternativeControlScheme();
    final inputManager = InputManager(defaultScheme);

    inputManager.switchScheme(alternativeScheme);

    expect(inputManager._currentScheme, alternativeScheme);
  });

  test('InputManager handles key event with current scheme', () {
    final defaultScheme = DefaultControlScheme();
    final inputManager = InputManager(defaultScheme);

    final event = RawKeyDownEvent(
      data: RawKeyEventDataAndroid(),
      character: null,
    );

    inputManager.handleKeyEvent(event);

    // Verify that the event was handled by the current scheme
  });
}
