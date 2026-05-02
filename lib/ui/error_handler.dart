import 'package:flutter/material.dart';
import 'package:rebcm/exceptions/ui_exception.dart';
import 'package:rebcm/ui/widgets/error_dialog.dart';

class ErrorHandler with ChangeNotifier {
  UiException? _exception;

  UiException? get exception => _exception;

  void handleError(UiException exception) {
    _exception = exception;
    notifyListeners();
  }

  void showErrorDialog(BuildContext context) {
    if (_exception != null) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(exception: _exception!),
      ).then((_) => _exception = null);
    }
  }
}
