import 'package:game/models/logging/package_log.dart';

class PackageLogger {
  List<PackageLog> _log = [];

  void logPackage(int id, String status) {
    _log.add(PackageLog(id: id, status: status, timestamp: DateTime.now()));
  }

  List<PackageLog> getLog() => _log;

  bool validateSequence() {
    for (var i = 1; i < _log.length; i++) {
      if (_log[i].id != _log[i - 1].id + 1) {
        return false;
      }
    }
    return true;
  }
}
