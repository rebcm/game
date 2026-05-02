import 'package:audio_service/audio_service.dart';
import 'package:rebcm/services/audio/audio_handler.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => AudioHandlerImpl(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.rebcm.game.channel.audio',
      androidNotificationChannelName: 'Rebeca Game Audio',
      androidNotificationOngoing: true,
    ),
  );
}
