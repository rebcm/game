import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class AudioCompressionService {
  Future<void> compressAudio(String inputFilePath, String outputFilePath) async {
    await FFmpegKit.execute(
      '-i $inputFilePath -c:a aac -b:a 128k $outputFilePath',
    );
  }
}
