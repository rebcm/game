import 'package:flutter/foundation.dart';

class LRUCache<K, V> {
  final int _capacity;
  final Map<K, V> _cache = {};
  final List<K> _order = [];

  LRUCache(this._capacity);

  V? get(K key) {
    if (_cache.containsKey(key)) {
      _order.remove(key);
      _order.add(key);
      return _cache[key];
    }
    return null;
  }

  void put(K key, V value) {
    if (_cache.containsKey(key)) {
      _order.remove(key);
    } else if (_cache.length >= _capacity) {
      final oldestKey = _order.removeAt(0);
      _cache.remove(oldestKey);
    }
    _cache[key] = value;
    _order.add(key);
  }

  void remove(K key) {
    _cache.remove(key);
    _order.remove(key);
  }

  void clear() {
    _cache.clear();
    _order.clear();
  }
}
