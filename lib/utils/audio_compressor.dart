import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class AudioCompressor {
  Future<void> compressAudio(String inputFile, String outputFile) async {
    await FFmpegKit.execute(
      '-i $inputFile -b:a 128k $outputFile',
    );
  }
}
