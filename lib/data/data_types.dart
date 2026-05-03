// Definição dos tipos de dados utilizados pelo passdriver Flutter

enum DataType {
  // TBD
}

class DataRequirement {
  final DataType type;
  final String description;
  final int volume;
  final int accessFrequency;
  final ConsistencyLevel consistencyLevel;

  DataRequirement({
    required this.type,
    required this.description,
    required this.volume,
    required this.accessFrequency,
    required this.consistencyLevel,
  });
}

enum ConsistencyLevel { strong, eventual }

