import 'package:flutter/foundation.dart';
import 'package:rebcm/game/features/gameplay/gameplay_events.dart';

class GameplayListener with ChangeNotifier {
  void listenToGameplayEvents() {
    GameplayEvents.instance.addListener(() {
      // Implement gameplay logic here
      // For example, react to impact events
    });
  }
}
