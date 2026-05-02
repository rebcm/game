import Intl.message('package:flutter/material.dart');
import Intl.message('package:audio_optimizer/audio_optimizer.dart');

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
        title: Text(Intl.message('Otimização de Áudio')),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _audioOptimizer.optimizeAudioFiles,
          child: Text(Intl.message('Otimizar Áudio')),
        ),
      ),
    );
  }
}
