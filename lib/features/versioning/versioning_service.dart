import 'package:flutter/services.dart';

class VersioningService {
  final VersioningProvider _versioningProvider;

  VersioningService(this._versioningProvider);

  Future<void> loadVersion() async {
    final version = await rootBundle.loadString('version.txt');
    _versioningProvider.updateVersion(version.trim());
  }
}
