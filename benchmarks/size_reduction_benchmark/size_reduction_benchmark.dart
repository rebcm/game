import 'dart:io';

void main() async {
  final currentSize = await File('build/app/outputs/flutter-apk/app-release.apk').length();
  final targetSize = currentSize * 0.85; // 15% reduction

  print('Current size: $currentSize bytes');
  print('Target size: $targetSize bytes');

  if (currentSize <= targetSize) {
    print('Size reduction target met!');
    exit(0);
  } else {
    print('Size reduction target not met!');
    exit(1);
  }
}
