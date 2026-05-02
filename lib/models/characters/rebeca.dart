import 'package:flutter/material.dart';

class Rebeca {
  final String skinPath;

  Rebeca({required this.skinPath});

  static Rebeca instance = Rebeca(skinPath: 'assets/characters/rebeca_skin.png');
}
