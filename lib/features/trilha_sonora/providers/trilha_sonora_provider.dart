import 'package:assets_audio_player/assets_audio_player.dart';

class TrilhaSonoraProvider {
  List<Audio> _musicas = [
    Audio('assets/musicas/musica1.mp3'),
    Audio('assets/musicas/musica2.mp3'),
    Audio('assets/musicas/musica3.mp3'),
    Audio('assets/musicas/musica4.mp3'),
  ];

  void init(AssetsAudioPlayer assetsAudioPlayer) {
    assetsAudioPlayer.open(
      Playlist(audios: _musicas),
      loopMode: LoopMode.playlist,
      transitionMode: TransitionMode.fadeIn(500),
    );
  }
}
