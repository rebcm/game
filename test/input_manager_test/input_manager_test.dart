import 'package:flutter_test/flutter_test.dart';
import 'package:game/input_manager/input_manager.dart';
import 'package:game/control_schemes/control_scheme.dart';

void main() {
  test('InputManager switches control scheme correctly', () {
    final initialScheme = DefaultControlScheme();
    final newScheme = AlternativeControlScheme();
    final inputManager = InputManager(initialScheme);

    inputManager.switchScheme(newScheme);

    expect(inputManager.currentScheme, newScheme);
  });
}
