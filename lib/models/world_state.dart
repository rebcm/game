class WorldState {
  final List<List<List<int>>> blocks;

  WorldState({required this.blocks});

  factory WorldState.fromJson(Map<String, dynamic> json) {
    return WorldState(
      blocks: List<List<List<int>>>.from(json['blocks'].map((x) => List<List<int>>.from(x.map((y) => List<int>.from(y))))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blocks': blocks.map((x) => x.map((y) => y).toList()).toList(),
    };
  }
}
