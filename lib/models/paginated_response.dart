import 'package:freezed/freezed.dart';

part 'paginated_response.freezed.dart';

@freezed
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required List<T> data,
    required int page,
    required int limit,
    required int total,
  }) = _PaginatedResponse;

  factory PaginatedResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return PaginatedResponse<T>(
      data: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
    );
  }
}
