import 'package:passdriver/features/gameplay/models/physics_event.dart';
import 'package:passdriver/features/gameplay/providers/physics_event_provider.dart';

class PhysicsGameplayService {
  final PhysicsEventProvider _physicsEventProvider;

  PhysicsGameplayService(this._physicsEventProvider);

  void handlePhysicsEvent(PhysicsEvent event) {
    if (event.type == PhysicsEventType.collision && event.intensity > 10) {
      // Trigger game event: perda de vida por impacto
      print('Perda de vida por impacto');
    } else if (event.type == PhysicsEventType.forceApplied) {
      // Trigger game event: trigger de checkpoint or detecção de queda do mapa
      print('Trigger de checkpoint or detecção de queda do mapa');
    }
    _physicsEventProvider.addEvent(event);
  }
}
