enum PlayerMovementTrigger {
  arrowUp,
  arrowDown,
  arrowLeft,
  arrowRight,
  keyW,
  keyA,
  keyS,
  keyD,
}

class PlayerMovementTriggerHandler {
  static bool isMovementTrigger(String input) {
    return PlayerMovementTrigger.values.any((trigger) => trigger.name == input);
  }

  static PlayerMovementTrigger? fromInput(String input) {
    try {
      return PlayerMovementTrigger.values.firstWhere((trigger) => trigger.name == input);
    } catch (_) {
      return null;
    }
  }
}
