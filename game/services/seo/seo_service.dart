import 'package:flutter/foundation.dart';

class SeoService with ChangeNotifier {
  List<String> _keywords = [];

  List<String> get keywords => _keywords;

  void updateKeywords(List<String> newKeywords) {
    _keywords = newKeywords;
    notifyListeners();
  }

  void addKeyword(String keyword) {
    if (!_keywords.contains(keyword)) {
      _keywords.add(keyword);
      notifyListeners();
    }
  }

  void removeKeyword(String keyword) {
    if (_keywords.contains(keyword)) {
      _keywords.remove(keyword);
      notifyListeners();
    }
  }
}
