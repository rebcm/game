import 'package:flutter_test/flutter_test.dart';
import 'package:game/cache/lru_cache.dart';

void main() {
  group('LRUCache', () {
    test('should get and put items', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      expect(cache.get(1), 'one');
      expect(cache.get(2), 'two');
    });

    test('should evict least recently used item', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      cache.get(1);
      cache.put(3, 'three');
      expect(cache.get(2), null);
    });

    test('should remove item', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.remove(1);
      expect(cache.get(1), null);
    });

    test('should clear cache', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      cache.clear();
      expect(cache.get(1), null);
      expect(cache.get(2), null);
    });
  });
}
