import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/cache_manager.dart';

void main() {
  group('CacheManager', () {
    test('initCache', () async {
      await CacheManager.initCache();
      // Add assertions here
    });

    test('clearCache', () async {
      await CacheManager.clearCache();
      // Add assertions here
    });
  });
}
