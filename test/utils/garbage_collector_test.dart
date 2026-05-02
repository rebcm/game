import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/garbage_collector.dart';

void main() {
  test('Garbage collector test', () {
    GarbageCollector.collect();
    expect(true, true);
  });
}
