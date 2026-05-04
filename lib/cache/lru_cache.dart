import 'package:quiver/collection.dart';

class LRUCache<K, V> {
  final int _capacity;
  final Map<K, V> _cache = {};
  late final LruMap<K, V> _lruMap;

  LRUCache(this._capacity) {
    _lruMap = LruMap<K, V>(maximumSize: _capacity);
  }

  V? get(K key) {
    return _lruMap[key];
  }

  void put(K key, V value) {
    _lruMap[key] = value;
  }

  void remove(K key) {
    _lruMap.remove(key);
  }

  void clear() {
    _lruMap.clear();
  }
}
