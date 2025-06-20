import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class NumberFactModel extends HiveObject {
  @HiveField(0)
  final String number;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String fact;

  NumberFactModel({
    required this.number,
    required this.category,
    required this.fact,
  });

  factory NumberFactModel.fromApi(String number, String category, String fact) {
    return NumberFactModel(number: number, category: category, fact: fact);
  }

  @override
  String toString() => '[$category] $number: $fact';
}
