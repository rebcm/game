import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('lint error test', (tester) async {
    // ignore: unused_local_variable
    var a = 1;
    var b = 2;
    // This line will cause a lint error
    // ignore: unnecessary_statements
    a + b;
  });
}
