import 'package:flutter/material.dart';

class AudioReproductionFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reprodução de Áudio')),
      body: Center(child: AudioPlayerWidget()),
    );
  }
}
