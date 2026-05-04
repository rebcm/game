import 'package:flutter/material.dart';

class FeedbackFormFields extends StatelessWidget {
  final TextEditingController setupTimeController;
  final TextEditingController confusionPointsController;
  final TextEditingController missingStepsController;

  const FeedbackFormFields({
    Key? key,
    required this.setupTimeController,
    required this.confusionPointsController,
    required this.missingStepsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: setupTimeController,
          decoration: const InputDecoration(
            labelText: 'Setup Time',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter setup time';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: confusionPointsController,
          decoration: const InputDecoration(
            labelText: 'Points of Confusion',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter points of confusion';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: missingStepsController,
          decoration: const InputDecoration(
            labelText: 'Missing Steps',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter missing steps';
            }
            return null;
          },
        ),
      ],
    );
  }
}
