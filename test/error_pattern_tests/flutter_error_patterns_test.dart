import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/error_patterns/flutter_error_patterns.dart';

void main() {
  test('Test critical error patterns', () {
    final patterns = FlutterErrorPatterns.criticalErrorPatterns;
    expect(patterns['Compilation failed'], isNotNull);
    expect(patterns['Test failed'], isNotNull);
    expect(patterns['Lint error'], isNotNull);
    // Add more tests as needed
  });

  test('Test regex patterns match', () {
    final patterns = FlutterErrorPatterns.criticalErrorPatterns;
    expect('Compilation failed: error message'.contains(RegExp(patterns['Compilation failed']!)), isTrue);
    expect('Test failed: error message'.contains(RegExp(patterns['Test failed']!)), isTrue);
    expect('Lint error: error message'.contains(RegExp(patterns['Lint error']!)), isTrue);
    // Add more tests as needed
  });
}
