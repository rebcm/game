import 'dart:io';
import 'package:rebcm/blocos/bloco.dart';

void main() async {
  final directory = Directory('lib/blocos');
  final files = await directory.list().where((entity) => entity.path.endsWith('.dart')).toList();

  final metadata = [];

  for (var file in files) {
    final content = await File(file.path).readAsString();
    final className = file.path.split('/').last.split('.').first;

    // Assuming the class has a constructor with named parameters for name and description
    final name = RegExp(r"const $className\({[^}]*name: '([^']*)'").firstMatch(content)?.group(1);
    final description = RegExp(r"const $className\({[^}]*description: '([^']*)'").firstMatch(content)?.group(1);

    if (name != null && description != null) {
      metadata.add({'className': className, 'name': name, 'description': description});
    }
  }

  final jsonData = metadata.map((e) => '{"className": "${e['className']}", "name": "${e['name']}", "description": "${e['description']}"}').join(',\n');
  final output = '[\n$jsonData\n]';

  await File('assets/blocos/metadata.json').writeAsString(output);
  print('Metadata extracted successfully!');
}

