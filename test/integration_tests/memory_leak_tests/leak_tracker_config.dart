import 'package:leak_tracker/leak_tracker.dart';

void configureLeakTracking() {
  LeakTracking.startTracking();
  LeakTracking.setRetainingPath(EstadoJogo);
}
