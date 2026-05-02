import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/audio_loop_test_widget.dart';
class AudioCompressionTestScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Teste de Compressão de Áudio'));
      body: Center(child: AudioLoopTestWidget()),
    );
  }
}
