import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rebecca_character_provider.dart';

class RebeccaCharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rebeccaProvider = context.watch<RebeccaCharacterProvider>();
    return rebeccaProvider.rebeccaModel.getSkin();
  }
}
