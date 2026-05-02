import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class I18nService {
  static final I18nService _instance = I18nService._();
  factory I18nService() => _instance;
  I18nService._();

  static Locale? _locale;

  Locale? get locale => _locale;

  void changeLocale(Locale locale) {
    _locale = locale;
    Intl.defaultLocale = locale.toString();
  }

  String? getTitle() {
    return Intl.message(
      'Construção Criativa',
      name: 'titulo',
      desc: 'Título do jogo',
    );
  }

  String? getInventoryText() {
    return Intl.message(
      'Inventário',
      name: 'inventario',
      desc: 'Texto do inventário',
    );
  }

  String? getSelectedBlockText() {
    return Intl.message(
      'Bloco Selecionado',
      name: 'bloco_selecionado',
      desc: 'Texto do bloco selecionado',
    );
  }
}
