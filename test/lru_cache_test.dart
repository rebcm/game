import 'package:flutter_test/flutter_test.dart';
import 'package:game/cache/lru_cache.dart';

void main() {
  group('LRUCache', () {
    test('initialization', () {
      final cache = LRUCache<int, String>(2);
      expect(cache.get(1), null);
    });

    test('put and get', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      expect(cache.get(1), 'one');
      expect(cache.get(2), 'two');
    });

    test('eviction', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      cache.put(3, 'three');
      expect(cache.get(1), null);
      expect(cache.get(2), 'two');
      expect(cache.get(3), 'three');
    });

    test('update', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      cache.put(1, 'one updated');
      expect(cache.get(1), 'one updated');
      expect(cache.get(2), 'two');
    });

    test('remove', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      cache.remove(1);
      expect(cache.get(1), null);
      expect(cache.get(2), 'two');
    });

    test('clear', () {
      final cache = LRUCache<int, String>(2);
      cache.put(1, 'one');
      cache.put(2, 'two');
      cache.clear();
      expect(cache.get(1), null);
      expect(cache.get(2), null);
    });
  });
}
