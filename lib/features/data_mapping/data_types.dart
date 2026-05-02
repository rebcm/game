import 'package:flutter/material.dart';

class DataType {
  final String name;
  final String structure; // chave-valor, binário or relacional
  final int volume;
  final int frequency;

  DataType({required this.name, required this.structure, required this.volume, required this.frequency});
}

class DataTypes with ChangeNotifier {
  List<DataType> _dataTypes = [];

  List<DataType> get dataTypes => _dataTypes;

  void addDataType(DataType dataType) {
    _dataTypes.add(dataType);
    notifyListeners();
  }

  void classifyDataTypes() {
    // TO BE IMPLEMENTED: classify data types by volume, frequency and structure
  }
}
