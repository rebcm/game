import 'package:flutter/foundation.dart';

class GameplayEvents with ChangeNotifier {
  static GameplayEvents? _instance;

  static GameplayEvents get instance {
    _instance ??= GameplayEvents._();
    return _instance!;
  }

  GameplayEvents._();

  void triggerEvent(GameplayEventType type, dynamic data) {
    // Implement event triggering logic here
    // For example, notify listeners about the event
    notifyListeners();
  }
}

enum GameplayEventType { impact, forceApplied }
