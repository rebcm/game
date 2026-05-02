import 'package:flutter/material.dart';
import 'package:passdriver/features/gameplay/providers/physics_event_provider.dart';
import 'package:passdriver/features/gameplay/services/physics_gameplay_service.dart';
import 'package:provider/provider.dart';

class GameplayScreen extends StatefulWidget {
  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late PhysicsGameplayService _physicsGameplayService;

  @override
  void initState() {
    super.initState();
    _physicsGameplayService = PhysicsGameplayService(Provider.of<PhysicsEventProvider>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Gameplay Screen'),
      ),
    );
  }
}
