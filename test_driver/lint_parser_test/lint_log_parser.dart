import 'dart:io';
import 'dart:convert';

void main(List<String> args) {
  final file = File(args[0]);
  final lines = file.readAsLinesSync();
  final issues = <Map<String, dynamic>>[];

  for (var line in lines) {
    if (line.contains('error') || line.contains('warning')) {
      final parts = line.split('•');
      if (parts.length >= 3) {
        issues.add({
          'type': parts[0].trim().contains('error') ? 'error' : 'warning',
          'file': parts[1].trim().split(' ').first,
          'message': parts.sublist(2).join('•').trim(),
        });
      }
    }
  }

  final jsonOutput = jsonEncode(issues, toEncodable: (dynamic item) => item.toString());
  print(jsonOutput);

  final outputFile = File('lint_issues.json');
  outputFile.writeAsStringSync(jsonOutput);
}
