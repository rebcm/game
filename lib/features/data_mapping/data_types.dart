enum DataType {
  lowVolume,
  mediumVolume,
  highVolume,
}

enum DataStructure {
  keyValue,
  binary,
  relational,
}

class DataClassification {
  final DataType type;
  final DataStructure structure;
  final String frequency;

  DataClassification({required this.type, required this.structure, required this.frequency});
}
