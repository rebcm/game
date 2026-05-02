import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/rebecca_profile/rebecca_profile_provider.dart';

class RebeccaProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rebeccaProfile = context.watch<RebeccaProfileProvider>();

    return Column(
      children: [
        Text(rebeccaProfile.rebeccaCharacter.description),
        Text(rebeccaProfile.rebeccaCharacter.appearance),
        Text(rebeccaProfile.rebeccaCharacter.style),
      ],
    );
  }
}
