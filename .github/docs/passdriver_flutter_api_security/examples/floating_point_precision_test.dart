// Example file for documenting floating point precision test
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Example Floating Point Test', () {
    double result = 0.1 + 0.2;
    expect(result, closeTo(0.3, 0.00001));
  });
}
