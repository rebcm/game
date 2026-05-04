import 'package:logger/logger.dart';

class PackageLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodIndentation: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void logPackageSequence(List<int> packageIds) {
    _logger.d('Package sequence: $packageIds');
  }

  static void logMissingPackages(List<int> expectedIds, List<int> actualIds) {
    final missingIds = expectedIds.where((id) => !actualIds.contains(id)).toList();
    _logger.e('Missing packages: $missingIds');
  }
}
