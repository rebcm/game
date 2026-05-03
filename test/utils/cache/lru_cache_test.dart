import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/cache/lru_cache.dart';

void main() {
  group('LRUCache', () {
    test('should cache and retrieve values', () {
      final cache = LRUCache<int, String>(2);
      cache.set(1, 'one');
      cache.set(2, 'two');
      expect(cache.get(1), 'one');
      expect(cache.get(2), 'two');
    });

    test('should evict least recently used item when cache is full', () {
      final cache = LRUCache<int, String>(2);
      cache.set(1, 'one');
      cache.set(2, 'two');
      cache.set(3, 'three');
      expect(cache.get(1), null);
      expect(cache.get(2), 'two');
      expect(cache.get(3), 'three');
    });

    test('should clear the cache', () {
      final cache = LRUCache<int, String>(2);
      cache.set(1, 'one');
      cache.set(2, 'two');
      cache.clear();
      expect(cache.get(1), null);
      expect(cache.get(2), null);
    });
  });
}
