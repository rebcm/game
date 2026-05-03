import 'package:freezed/freezed.dart';

part 'performance_indexes.freezed.dart';

@freezed
class PerformanceIndex with _$PerformanceIndex {
  const factory PerformanceIndex({
    required int id,
    required int worldId,
    required DateTime timestamp,
    required double r2Reference,
  }) = _PerformanceIndex;

  factory PerformanceIndex.fromJson(Map<String, dynamic> json) => _$PerformanceIndexFromJson(json);
}
