import 'package:flutter/material.dart';
import 'package:audio_optimizer/audio_optimizer.dart';

class AudioOptimizerScreen extends StatefulWidget {
  @override
  _AudioOptimizerScreenState createState() => _AudioOptimizerScreenState();
}

class _AudioOptimizerScreenState extends State<AudioOptimizerScreen> {
  final AudioOptimizer _audioOptimizer = AudioOptimizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otimização de Áudio'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _audioOptimizer.optimizeAudioFiles,
          child: Text('Otimizar Áudio'),
        ),
      ),
    );
  }
}
