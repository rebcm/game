import 'package:logger/logger.dart';

class JobLogger {
  final Logger _logger = Logger();

  void logJobStart(String jobName) => _logger.i('Job started: $jobName');
  void logJobEnd(String jobName) => _logger.i('Job ended: $jobName');
  void logJobError(String jobName, dynamic error) => _logger.e('Job error: $jobName', error);
}
