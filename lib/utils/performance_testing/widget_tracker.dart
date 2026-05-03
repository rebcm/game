class WidgetTracker {
  int _rebuildCount = 0;

  int get rebuildCount => _rebuildCount;

  void incrementRebuildCount() {
    _rebuildCount++;
  }

  void resetRebuildCount() {
    _rebuildCount = 0;
  }
}
