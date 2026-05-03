import 'package:flutter/material.dart';
import 'package:game/services/walkthrough_service.dart';
import 'package:provider/provider.dart';

class WalkthroughWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walkthroughService = Provider.of<WalkthroughService>(context);

    return Column(
      children: [
        Text('Step ${walkthroughService.currentStep + 1}'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: walkthroughService.previousStep,
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: walkthroughService.nextStep,
          child: Text('Next'),
        ),
      ],
    );
  }
}
