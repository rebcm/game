import 'package:leak_tracker/leak_tracker.dart';

void configureLeakTracking() {
  LeakTracking.dispatcher.addListener((event) {
    // Implementar lógica para lidar com eventos de vazamento de memória
  });
}
