import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:passdriver/features/trilha_sonora/providers/trilha_sonora_provider.dart';

class TrilhaSonora extends StatefulWidget {
  @override
  _TrilhaSonoraState createState() => _TrilhaSonoraState();
}

class _TrilhaSonoraState extends State<TrilhaSonora> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId('trilha_sonora');
  final TrilhaSonoraProvider _trilhaSonoraProvider = TrilhaSonoraProvider();

  @override
  void initState() {
    super.initState();
    _trilhaSonoraProvider.init(_assetsAudioPlayer);
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
