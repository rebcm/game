import 'package:flutter/services.dart' library;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AudioOptimizer {
  Future<void> optimizeAudioFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = await directory.list().toList();

    for (var file in files) {
      if (file.path.endsWith('.wav')) {
        final filePath = file.path;
        final fileName = basenameWithoutExtension(file.path);
        final optimizedFilePath = join(directory.path, '.ogg');

        await _convertToOgg(filePath, optimizedFilePath);
        await file.delete();
      }
    }
  }

  Future<void> _convertToOgg(String inputFilePath, String outputFilePath) async {
    final process = await Process.start(
      'ffmpeg',
      [
        '-i',
        inputFilePath,
        '-c:a',
        'libvorbis',
        '-b:a',
        '128k',
        outputFilePath,
      ],
    );

    await process.exitCode;
  }
}
