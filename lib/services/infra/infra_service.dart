import 'package:game/services/logging/error_logger.dart';

class InfraService {
  Future<void> performInfraOperation() async {
    try {
      // Infra operation logic here
    } catch (e, stackTrace) {
      ErrorLogger.logInfraError('Infra operation failed', e, stackTrace);
    }
  }
}
