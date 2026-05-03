import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;

class InputServiceWeb extends InputService {
  void init() {
    html.document.addEventListener('keydown', (event) {
      if ([
        'w',
        'a',
        's',
        'd',
        ' ',
      ].contains((event as html.KeyboardEvent).key.toLowerCase())) {
        event.preventDefault();
      }
    });
  }
}
