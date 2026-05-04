import 'package:freezed/freezed.dart';

part 'package_log.freezed.dart';
part 'package_log.g.dart';

@freezed
class PackageLog with _$PackageLog {
  const factory PackageLog({
    required int id,
    required String status,
    required DateTime timestamp,
  }) = _PackageLog;

  factory PackageLog.fromJson(Map<String, dynamic> json) => _$PackageLogFromJson(json);
}
