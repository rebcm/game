import 'package:flutter/material.dart';
import 'package:passdriver/features/documentation_checklist/models/documentation_checklist.dart';

class DocumentationChecklistProvider with ChangeNotifier {
  List<DocumentationChecklist> _checklists = [];

  List<DocumentationChecklist> get checklists => _checklists;

  void addChecklist(DocumentationChecklist checklist) {
    _checklists.add(checklist);
    notifyListeners();
  }

  void validateChecklist(DocumentationChecklist checklist) {
    if (checklist.title.length > checklist.maxCharacters) {
      throw FlutterError('Título excede o limite de caracteres');
    }
    if (checklist.hasCTA && checklist.link.isEmpty) {
      throw FlutterError('Link não pode ser vazio quando CTA está presente');
    }
  }
}
