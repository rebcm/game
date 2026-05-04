import 'package:mockito/mockito.dart';
import 'package:game/services/audio_service.dart';

class MockAudioService extends Mock implements AudioService {
  @override
  Future<bool> playSound(String soundFile) async {
    return super.noSuchMethod(Invocation.method(#playSound, [soundFile]), returnValue: Future.value(false));
  }

  @override
  bool get isMuted => super.noSuchMethod(Invocation.getter(#isMuted), returnValue: false);
}
