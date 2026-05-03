import 'dart:io';
import 'package:leak_tracker/leak_tracker.dart';

void main(List<String> args) {
  if (args.contains('--output')) {
    final outputFile = args[args.indexOf('--output') + 1];
    final snapshot = LeakTracker.getSnapshot();
    File(outputFile).writeAsStringSync(snapshot.toString());
    print('Memory snapshot saved to $outputFile');
  } else {
    print('Please provide an output file name using --output');
    exit(1);
  }
}
