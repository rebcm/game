import 'dart:io';
import 'package:game/docs/bloco_documentation/bloco_documentation.dart';

void main() async {
  // Implement logic to extract bloco documentation
  // For demonstration, assume we have a list of blocos
  List<Bloco> blocos = [
    Bloco(id: '1', descricao: 'Bloco 1', categoria: 'Categoria 1'),
    Bloco(id: '2', descricao: 'Bloco 2', categoria: 'Categoria 2'),
  ];

  BlocoDocumentation documentation = BlocoDocumentation(blocos: blocos);

  File outputFile = File('./lib/docs/bloco_documentation/output.json');
  await outputFile.writeAsString(jsonEncode(documentation.toJson()));
}

extension BlocoDocumentationToJson on BlocoDocumentation {
  Map<String, dynamic> toJson() {
    return {
      'blocos': blocos.map((bloco) => bloco.toJson()).toList(),
    };
  }
}

extension BlocoToJson on Bloco {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'categoria': categoria,
    };
  }
}
