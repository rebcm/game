import 'package:flutter/material.dart';
import 'package:passdriver/features/data_mapping/data_types.dart';

class DataFrequency with ChangeNotifier {
  final DataTypes _dataTypes;

  DataFrequency(this._dataTypes);

  void calculateFrequency() {
    // TO BE IMPLEMENTED: calculate frequency of access for each data type
  }
}
