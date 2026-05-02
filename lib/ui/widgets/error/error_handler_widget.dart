import 'package:flutter/material.dart';
import 'package:rebcm/exceptions/flutter_error_handler.dart';

class ErrorHandlerWidget extends StatelessWidget {
  final Widget child;

  const ErrorHandlerWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorHandler(
      onError: (error) {
        FlutterErrorHandler.handleError(error);
        // Show ErrorDialog here if needed
      },
      child: child,
    );
  }
}
