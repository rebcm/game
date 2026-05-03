import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MemoryTestUtils {
  static Future<void> checkMemoryLeak(Object instance) async {
    final snapshot1 = Snapshot.current();
    final before = snapshot1.objects.where((e) => e.isInstanceOf(instance.runtimeType.toString()));

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    final snapshot2 = Snapshot.current();
    final after = snapshot2.objects.where((e) => e.isInstanceOf(instance.runtimeType.toString()));

    expect(after.length, lessThan(before.length));
  }
}
