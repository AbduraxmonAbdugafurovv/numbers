import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:numbersapp/models/models.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://numbersapi.com'));
  final box = Hive.box<NumberFactModel>('saved_facts');
  bool isConnect = false;

  Future<NumberFactModel> fetchNumberFact({
    required String number,
    required String category,
  }) async {
    await checkInternet();

    if (isConnect == true) {
      final response = await _dio.get('/$number/$category');
      return NumberFactModel.fromApi(
        number,
        category,
        response.data.toString(),
      );
    } else {
      final matches =
          box.values
              .where((e) => e.number == number && e.category == category)
              .toList();
      if (matches.isNotEmpty) {
        return matches[0];
      } else {
        return NumberFactModel(
          number: number,
          category: category,
          fact: 'Malumot mavjud emas (offline)',
        );
      }
    }
  }

  Future<void> checkInternet() async {
    final result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      isConnect = false;
    } else {
      // Internetga real ulanib turganini sinab ko‘ramiz (GET so‘rov bilan)
      try {
        final response = await Dio()
            .get('https://www.google.com')
            .timeout(const Duration(seconds: 3));
        isConnect = response.statusCode == 200;
      } catch (e) {
        isConnect = false;
      }
    }
  }
}
