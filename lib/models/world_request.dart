class WorldRequest {
  final String data;

  WorldRequest({required this.data});

  Map<String, dynamic> toJson() {
    return {'data': data};
  }
}
