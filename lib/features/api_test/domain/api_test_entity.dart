class ApiTestEntity {
  final String data;

  ApiTestEntity({required this.data});

  factory ApiTestEntity.fromJson(String json) {
    // implement json parsing logic here
    return ApiTestEntity(data: json);
  }
}
