import 'package:flutter/foundation.dart';

class SecretValidator {
  static const String _prefix = 'reb_';
  static const int _minLength = 16;

  static bool isValid(String? secret) {
    if (secret == null || secret.isEmpty) return false;
    if (!secret.startsWith(_prefix)) return false;
    if (secret.length < _minLength) return false;
    return true;
  }
}
