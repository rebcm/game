import 'package:flutter/material.dart';

class AudioGainWidget extends StatefulWidget {
  const AudioGainWidget({Key? key}) : super(key: key);

  @override
  State<AudioGainWidget> createState() => _AudioGainWidgetState();
}

class _AudioGainWidgetState extends State<AudioGainWidget> {
  String _audioGainStatus = '';

  void _checkAudioGain() {
    // implement logic to check audio gain
    setState(() {
      _audioGainStatus = 'OK';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _checkAudioGain,
          child: const Text('Check Audio Gain'),
        ),
        Text('Audio Gain: $_audioGainStatus', key: const Key('audioGain')),
      ],
    );
  }
}
