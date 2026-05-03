import 'package:flutter/services.dart';
import 'package:game/utils/logs/error_logger.dart';

class PassdriverService {
  Future<void> authenticate() async {
    try {
      // Existing authentication logic
    } on PlatformException catch (e) {
      if (e.code == 'AUTH_ERROR_CODE') {
        ErrorLogger.logAuthError(e);
      } else {
        ErrorLogger.logInfraError(e);
      }
    } catch (e, stackTrace) {
      ErrorLogger.logPayloadError(e, stackTrace: stackTrace);
    }
  }
}
