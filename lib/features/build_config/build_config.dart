import 'package:flutter/foundation.dart';

class BuildConfig with ChangeNotifier {
  static const _branchBuildExpiration = Duration(hours: 2);
  static const _tagBuildExpiration = Duration(days: 365);

  Duration getBuildExpiration({required bool isTagBuild}) {
    return isTagBuild ? _tagBuildExpiration : _branchBuildExpiration;
  }
}
