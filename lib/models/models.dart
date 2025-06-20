class NumberFactModel {
  final String number;
  final String category;
  final String fact;

  NumberFactModel({
    required this.number,
    required this.category,
    required this.fact,
  });

  factory NumberFactModel.fromApi(String number, String category, String fact) {
    return NumberFactModel(number: number, category: category, fact: fact);
  }

  factory NumberFactModel.fromJson(Map<String, dynamic> json) {
    return NumberFactModel(
      number: json['number'],
      category: json['category'],
      fact: json['fact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'category': category,
      'fact': fact,
    };
  }

  @override
  String toString() => '[$category] $number: $fact';
}
