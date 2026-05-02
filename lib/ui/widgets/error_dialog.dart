import 'package:flutter/material.dart';
import 'package:rebcm/exceptions/ui_exception.dart';

class ErrorDialog extends StatelessWidget {
  final UiException exception;

  const ErrorDialog({Key? key, required this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(exception.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
