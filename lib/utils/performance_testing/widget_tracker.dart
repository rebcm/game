abstract class WidgetTracker {
  Future<void> trackRebuilds(AsyncCallback callback);
  int get rebuildCount;
}
