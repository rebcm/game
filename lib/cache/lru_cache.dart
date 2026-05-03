import 'package:quiver/collection.dart';

class LRUCache<K, V> {
  final int _capacity;
  final Map<K, V> _cache;
  final LinkedHashMap<K, V> _lru;

  LRUCache(this._capacity) 
    : _cache = {}, 
      _lru = LinkedHashMap<K, V>(
        equals: (k1, k2) => k1 == k2,
        hashCode: (k) => k.hashCode,
      );

  V? get(K key) {
    if (_lru.containsKey(key)) {
      final value = _lru[key];
      _lru.remove(key);
      _lru[key] = value!;
      return value;
    }
    return null;
  }

  void put(K key, V value) {
    if (_lru.containsKey(key)) {
      _lru.remove(key);
    } else if (_lru.length >= _capacity) {
      final oldestKey = _lru.keys.first;
      _lru.remove(oldestKey);
    }
    _lru[key] = value;
  }

  void remove(K key) {
    _lru.remove(key);
  }

  void clear() {
    _lru.clear();
  }
}
