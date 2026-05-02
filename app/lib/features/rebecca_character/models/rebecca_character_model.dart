import 'package:flutter/material.dart';

class RebeccaCharacterModel {
  final String skinPath;

  RebeccaCharacterModel({required this.skinPath});

  Image getSkin() {
    return Image.asset(skinPath);
  }
}
