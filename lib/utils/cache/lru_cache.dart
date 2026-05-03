import 'package:quiver/cache.dart';
import 'package:quiver/collection.dart';

class LRUCache<K, V> {
  final int _maxSize;
  final MapCache<K, V> _cache;

  LRUCache(this._maxSize) : _cache = MapCache<K, V>(lru: LinkedHashMap<K, V>());

  V? get(K key) => _cache.get(key);

  void set(K key, V value) {
    _cache.set(key, value);
    if (_cache.length > _maxSize) {
      _cache.evict(_cache.keys.first);
    }
  }

  void evict(K key) => _cache.evict(key);

  void clear() => _cache.clear();
}
