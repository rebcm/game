class PassdriverDataModel {
  final String tips;

  PassdriverDataModel({required this.tips});

  factory PassdriverDataModel.fromJson(Map<String, dynamic> json) {
    return PassdriverDataModel(tips: json['tips']);
  }
}
