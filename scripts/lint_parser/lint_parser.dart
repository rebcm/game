import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  final result = await Process.run('flutter', ['analyze']);
  final output = result.stdout.toString() + result.stderr.toString();
  final issues = parseLintOutput(output);
  final jsonOutput = jsonEncode(issues);
  print(jsonOutput);
  await File('lint_issues.json').writeAsString(jsonOutput);
}

List<Issue> parseLintOutput(String output) {
  final issues = <Issue>[];
  final lines = output.split('\n');
  for (var line in lines) {
    if (line.contains('error') || line.contains('warning')) {
      final issue = Issue.fromString(line);
      if (issue != null) {
        issues.add(issue);
      }
    }
  }
  return issues;
}

class Issue {
  final String path;
  final int line;
  final String message;
  final String severity;

  Issue({required this.path, required this.line, required this.message, required this.severity});

  factory Issue.fromString(String line) {
    // Simple parsing logic, might need to be adjusted based on actual output format
    final parts = line.split(':');
    if (parts.length < 4) return null;
    final path = parts[0];
    final lineNumber = int.tryParse(parts[1]) ?? 0;
    final severity = parts[2].trim();
    final message = parts.sublist(3).join(':').trim();
    return Issue(path: path, line: lineNumber, message: message, severity: severity);
  }

  Map<String, dynamic> toJson() => {
    'path': path,
    'line': line,
    'message': message,
    'severity': severity,
  };
}
