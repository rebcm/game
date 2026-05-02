import 'package:flutter/material.dart';

abstract class BaseController with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
