import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

void main() async {
  await FFmpegKit.execute('-i assets/audio/original/input.wav -c:a libvorbis assets/audio/optimized/output.ogg');
}
