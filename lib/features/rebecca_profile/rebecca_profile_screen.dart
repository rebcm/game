import 'package:flutter/material.dart';
import 'package:passdriver/features/rebecca_profile/widgets/rebecca_profile_widget.dart';

class RebeccaProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil da Rebeca'),
      ),
      body: RebeccaProfileWidget(),
    );
  }
}
