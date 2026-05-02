import 'package:flutter/material.dart';

class MundoValidator with ChangeNotifier {
  String? validateUserIdentity(String userId) {
    if (userId.isEmpty) {
      return 'Usuário não identificado';
    }
    return null;
  }

  String? validateWorldCreationLimit(int userWorldsCount, int maxWorlds) {
    if (userWorldsCount >= maxWorlds) {
      return 'Limite de mundos criados atingido';
    }
    return null;
  }
}
