import 'package:flutter/foundation.dart';

class WorldPayloadModel {
  final String name;
  final List<int> chunkData;

  WorldPayloadModel({required this.name, required this.chunkData});

  factory WorldPayloadModel.fromJson(Map<String, dynamic> json) {
    return WorldPayloadModel(
      name: json['name'],
      chunkData: List<int>.from(json['chunkData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'chunkData': chunkData,
    };
  }
}
