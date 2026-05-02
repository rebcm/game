import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride_hailing/services/ride_hailing_logger.dart';

class RideHailingProvider with ChangeNotifier {
  late RideHailingLogger _logger;

  RideHailingProvider(BuildContext context) {
    _logger = RideHailingLogger(Logger());
  }

  void handleError(dynamic error) {
    if (error is AuthenticationError) {
      _logger.logAuthenticationError(error.message);
    } else if (error is TimeoutError) {
      _logger.logTimeoutError(error.message);
    } else if (error is PayloadLimitError) {
      _logger.logPayloadLimitError(error.message);
    }
  }
}
