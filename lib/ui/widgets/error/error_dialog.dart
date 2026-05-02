import 'package:flutter/material.dart';
import 'package:rebcm/exceptions/app_exception.dart';

class ErrorDialog extends StatelessWidget {
  final AppException exception;

  const ErrorDialog({Key? key, required this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error ${exception.code}'),
      content: Text(exception.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
