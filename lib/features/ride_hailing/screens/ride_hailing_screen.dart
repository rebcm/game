import 'package:flutter/material.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_logger.dart';

class RideHailingScreen extends StatefulWidget {
  @override
  _RideHailingScreenState createState() => _RideHailingScreenState();
}

class _RideHailingScreenState extends State<RideHailingScreen> {
  final RideHailingLogger _logger = RideHailingLogger(Logger());

  void _handleError(dynamic error) {
    if (error is AuthenticationError) {
      _logger.logAuthenticationError(error.message);
    } else if (error is TimeoutError) {
      _logger.logTimeoutError(error.message);
    } else if (error is PayloadLimitError) {
      _logger.logPayloadLimitError(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Hailing'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            try {
              // Simulating an error
              throw AuthenticationError('Invalid credentials');
            } catch (e) {
              _handleError(e);
            }
          },
          child: Text('Simulate Error'),
        ),
      ),
    );
  }
}

class AuthenticationError implements Exception {
  final String message;

  AuthenticationError(this.message);
}

class TimeoutError implements Exception {
  final String message;

  TimeoutError(this.message);
}

class PayloadLimitError implements Exception {
  final String message;

  PayloadLimitError(this.message);
}
