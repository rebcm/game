import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class StateSizeAnalyzer {
  static void analyze(BuildContext context) {
    final providers = [
      context.read<Provider1>(),
      context.read<Provider2>(),
      // Add other providers here
    ];

    for (var provider in providers) {
      final size = _calculateSize(provider);
      if (kDebugMode) {
        print('Size of ${provider.runtimeType}: $size bytes');
      }
    }
  }

  static int _calculateSize(Object object) {
    return _sizeOf(object);
  }

  static int _sizeOf(Object object) {
    var size = _primitiveSize(object);
    if (size != null) return size;

    if (object is List) {
      size = object.length * _pointerSize;
      for (var element in object) {
        size += _sizeOf(element);
      }
      return size;
    } else if (object is Map) {
      size = object.length * (_pointerSize * 2);
      object.forEach((key, value) {
        size += _sizeOf(key);
        size += _sizeOf(value);
      });
      return size;
    }

    return _instanceSize(object);
  }

  static int? _primitiveSize(Object object) {
    if (object is int) return 8;
    if (object is double) return 8;
    if (object is bool) return 1;
    return null;
  }

  static int get _pointerSize => 8; // Assuming 64-bit architecture

  static int _instanceSize(Object object) {
    // This is a simplified version and may not be entirely accurate.
    // It assumes that the instance size is roughly the sum of its fields.
    var size = 0;
    object.toString(); // Force reflection
    // Using reflection to get the fields would be more accurate but is complex.
    // For simplicity, this example assumes a fixed size for non-primitive objects.
    size = _pointerSize;
    return size;
  }
}
