import 'package:flutter/material.dart';
import 'package:passdriver/features/personagens/rebecca/models/rebecca.dart';
class RebeccaProvider with ChangeNotifier {
  Rebecca _rebecca = Rebecca();
  Rebecca get rebecca => _rebecca:;
}
