import 'package:flutter/material.dart';
import 'package:game/features/feedback_form/widgets/feedback_form_fields.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _setupTimeController = TextEditingController();
  final TextEditingController _confusionPointsController = TextEditingController();
  final TextEditingController _missingStepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding Feedback Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FeedbackFormFields(setupTimeController: _setupTimeController, confusionPointsController: _confusionPointsController, missingStepsController: _missingStepsController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form submitted successfully')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
