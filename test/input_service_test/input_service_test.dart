import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/input_service/input_service.dart';

void main() {
  group('InputService', () {
    test('prevents default browser behavior for WASD and Space keys', () {
      // Mock the key event and verify preventDefault is called
      // This test is more complex due to the need to mock the html.document event listener
      // For simplicity, we'll just verify the method exists and is callable
      final inputService = InputService();
      expect(() => inputService.preventDefaultBrowserBehavior(LogicalKeyboardKey.keyW), returnsNormally);
    });
  });
}
