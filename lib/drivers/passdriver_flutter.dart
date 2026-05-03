import 'package:flutter/services.dart';
import 'package:game/services/logging/error_logger.dart';
import 'package:game/utils/error_handling.dart';

class PassdriverFlutter {
  static const MethodChannel _channel = MethodChannel('passdriver_flutter');

  static Future<void> init() async {
    try {
      await _channel.invokeMethod('init');
    } on PlatformException catch (e, stackTrace) {
      ErrorHandling.handleError(e, stackTrace);
    }
  }

  static Future<void> authenticate() async {
    try {
      await _channel.invokeMethod('authenticate');
    } on PlatformException catch (e, stackTrace) {
      ErrorHandling.handleError(AuthException('Authentication failed'), stackTrace);
    }
  }

  static Future<void> sendPayload() async {
    try {
      await _channel.invokeMethod('sendPayload');
    } on PlatformException catch (e, stackTrace) {
      ErrorHandling.handleError(PayloadException('Payload sending failed'), stackTrace);
    }
  }
}
