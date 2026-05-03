import 'dart:developer';
import 'package:flutter/foundation.dart';

class MemoryLeakHelper {
  static void checkMemoryLeak(Object object) {
    if (kDebugMode) {
      final snapshot = HeapSnapshot();
      snapshot.collect().then((_) {
        final retainedSize = snapshot.objects
            .where((element) => element.identityHashCode == object.hashCode)
            .map((e) => e.retainedSize)
            .reduce((value, element) => value + element);
        if (retainedSize > 0) {
          debugPrint('Memória retida por $object: $retainedSize bytes');
        }
      });
    }
  }
}
