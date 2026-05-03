import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main(List<String> args) async {
  int retryCount = int.parse(Platform.environment['RETRY_COUNT'] ?? '0');
  bool testPassed = false;

  for (int i = 0; i <= retryCount; i++) {
    testPassed = await runTests();
    if (testPassed) break;
  }

  if (!testPassed) exit(1);
}

Future<bool> runTests() async {
  // run existing tests here
  return true; // return true if tests pass, false otherwise
}
