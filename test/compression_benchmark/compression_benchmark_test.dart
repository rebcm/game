import 'package:test/test.dart';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  group('Compression Benchmark', () {
    test('GZip vs Zstd compression', () {
      List<int> sizes = [1024, 2048, 4096, 8192, 16384];
      for (int size in sizes) {
        List<int> data = List<int>.generate(size, (i) => i % 256);
        Uint8List bytes = Uint8List.fromList(data);

        Stopwatch stopwatch = Stopwatch()..start();
        List<int> gzipCompressed = gzip.encode(bytes);
        int gzipTime = stopwatch.elapsedMilliseconds;

        stopwatch.reset();
        List<int> zstdCompressed = Zstd.encode(bytes);
        int zstdTime = stopwatch.elapsedMilliseconds;

        print('Size: $size bytes');
        print('GZip compression time: $gzipTime ms, ratio: ${bytes.length / gzipCompressed.length}');
        print('Zstd compression time: $zstdTime ms, ratio: ${bytes.length / zstdCompressed.length}');
      }
    });
  });
}
