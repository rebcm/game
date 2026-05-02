import 'package:sons_em_musica/presentation/audio_player_widget.dart';

class GameLoop extends StatefulWidget {
  @override
  _GameLoopState createState() => _GameLoopState();
}

class _GameLoopState extends State<GameLoop> {
  @override
  Widget build(BuildContext context) {
    return AudioPlayerWidget();
  }
}
