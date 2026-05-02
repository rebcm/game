import 'package:flutter/material.dart';
import 'package:passdriver/features/documentation/models/documentation_criteria.dart';

class DocumentationProvider with ChangeNotifier {
  DocumentationCriteria? _criteria;

  DocumentationCriteria? get criteria => _criteria;

  void setCriteria(DocumentationCriteria criteria) {
    _criteria = criteria;
    notifyListeners();
  }

  Future<void> loadCriteria() async {
    // Implement loading criteria from storage or API
  }
}
