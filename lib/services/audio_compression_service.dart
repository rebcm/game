import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class AudioCompressionService {
  Future<void> compressAudio(String inputPath, String outputPath) async {
    await FFmpegKit.execute(
      '-i $inputPath -c:a libopus -b:a 128k $outputPath',
    );
  }
}
