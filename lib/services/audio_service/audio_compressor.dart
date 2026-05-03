import 'package:ffmpeg_kit_flutter/ffmpeg_kit_flutter.dart';

class AudioCompressor {
  Future<void> compressAudio(String inputPath, String outputPath, String bitrate) async {
    await FFmpegKit.execute(
      '-i $inputPath -c:a libmp3lame -b:a $bitrate $outputPath',
    );
  }
}
