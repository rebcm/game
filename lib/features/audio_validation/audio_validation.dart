import 'dart:io';
import 'package:flutter/foundation.dart';

Future<bool> validateAudioFormat(String format) async {
  if (Platform.isAndroid) {
    return ['ogg', 'mp3'].contains(format);
  } else if (Platform.isIOS) {
    return ['mp3'].contains(format); // ogg is not natively supported on iOS
  } else {
    return false;
  }
}
