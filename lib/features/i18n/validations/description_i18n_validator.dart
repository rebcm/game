import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DescriptionI18nValidator {
  static String? validateDescription(String description, String locale) {
    if (description.isEmpty) {
      return Intl.message('Descrição é obrigatória', name: 'descriptionRequired');
    }
    if (description.length < 10) {
      return Intl.message('Descrição deve ter pelo menos 10 caracteres', name: 'descriptionMinLength');
    }
    return null;
  }
}
