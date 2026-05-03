import 'package:flutter/foundation.dart';

class NameService with ChangeNotifier {
  final List<String> _names = [];

  Future<bool> addName(String name) async {
    if (_names.contains(name)) {
      return false;
    }
    _names.add(name);
    notifyListeners();
    return true;
  }
}
