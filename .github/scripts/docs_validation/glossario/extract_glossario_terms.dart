import 'dart:io';
import 'package:markdown/markdown.dart';

void main() {
  final dicasDir = Directory('lib/dicas');
  final glossario = <String, String>{};

  dicasDir.listSync(recursive: true).where((entity) => entity.path.endsWith('.md')).forEach((file) {
    final content = File(file.path).readAsStringSync();
    final document = Document().parse(content);
    document.nodes.whereType<Element>().forEach((element) {
      if (element.tag == 'code') {
        final term = element.text;
        final description = element.parent?.previousSibling?.text.trim() ?? '';
        glossario[term] = description;
      }
    });
  });

  final glossarioFile = File('.github/docs/glossario.md');
  glossarioFile.writeAsStringSync('# Glossário\n\n');
  glossario.forEach((term, description) {
    glossarioFile.writeAsStringSync('## $term\n$description\n\n', mode: FileMode.append);
  });
}
