import 'dart:math';
import 'package:hive/hive.dart';
import 'package:numbersapp/models/models.dart';


class NumberLocalDataSource {
  final Box<NumberFactModel> box;

  NumberLocalDataSource(this.box);

  Future<void> cacheFact(NumberFactModel model) async {
    await box.add(model);
  }

  NumberFactModel? getFactByNumberAndCategory(String number, String category) {
    try {
      return box.values.lastWhere(
        (fact) => fact.number == number && fact.category == category,
      );
    } catch (_) {
      return null;
    }
  }

  NumberFactModel? getRandomFactByCategory(String category) {
    final filtered = box.values
        .where((fact) => fact.category == category)
        .toList();

    if (filtered.isNotEmpty) {
      final randomIndex = Random().nextInt(filtered.length);
      return filtered[randomIndex];
    }
    return null;
  }
}
