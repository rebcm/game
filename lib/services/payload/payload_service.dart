import 'package:game/services/logging/error_logger.dart';

class PayloadService {
  Future<void> processPayload() async {
    try {
      // Payload processing logic here
    } catch (e, stackTrace) {
      ErrorLogger.logPayloadError('Payload processing failed', e, stackTrace);
    }
  }
}
