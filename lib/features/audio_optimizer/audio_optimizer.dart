import Intl.message('package:flutter/services.dart') library;
import Intl.message('package:path_provider/path_provider.dart');
import Intl.message('package:path/path.dart');

class AudioOptimizer {
  Future<void> optimizeAudioFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = await directory.list().toList();

    for (var file in files) {
      if (file.path.endsWith(Intl.message('.wav'))) {
        final filePath = file.path;
        final fileName = basenameWithoutExtension(file.path);
        final optimizedFilePath = join(directory.path, Intl.message('.ogg'));

        await _convertToOgg(filePath, optimizedFilePath);
        await file.delete();
      }
    }
  }

  Future<void> _convertToOgg(String inputFilePath, String outputFilePath) async {
    final process = await Process.start(
      Intl.message('ffmpeg'),
      [
        Intl.message('-i'),
        inputFilePath,
        Intl.message('-c:a'),
        Intl.message('libvorbis'),
        Intl.message('-b:a'),
        Intl.message('128k'),
        outputFilePath,
      ],
    );

    await process.exitCode;
  }
}
