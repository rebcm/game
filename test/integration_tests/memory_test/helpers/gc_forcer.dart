import 'dart:ffi';
import 'package:flutter/foundation.dart';

class GCForcer {
  static void forceGC() {
    try {
      final Pointer<Uint8> largeAllocation = calloc.allocate<Uint8>(1024 * 1024 * 10);
      calloc.free(largeAllocation);
    } finally {
      // Trigger GC explicitly
      malloc.trim(1024 * 1024 * 10);
    }
  }
}
