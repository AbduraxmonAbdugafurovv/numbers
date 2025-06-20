import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:numbersapp/models/models.dart';
import 'package:numbersapp/service/connectivity_service.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://numbersapi.com'));
  final box = Hive.box<NumberFactModel>('saved_facts');
  final connectivityService = ConnectivityService();
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


     final matches = box.values.where(
  (e) => e.number == number && e.category == category,
).toList();


    if (matches.isNotEmpty) {
      print("📦 Hive’dan topildi");
      return matches[0];
    } else {
      print("🚫 Hive’da mavjud emas");
      return NumberFactModel(
        number: number,
        category: category,
        fact: 'Ma’lumot mavjud emas (offline)',
      );
    }

      
      // return NumberFactModel(
      //   number: "Number",
      //   category: "Category",
      //   fact: "Fact",
      // );
    }
  }

 Future<void> checkInternet() async {
  final result = await Connectivity().checkConnectivity();

  if (result == ConnectivityResult.none) {
    isConnect = false;
  } else {
    // Internetga real ulanib turganini sinab ko‘ramiz (GET so‘rov bilan)
    try {
      final response = await Dio().get('https://www.google.com')
          .timeout(const Duration(seconds: 3));
      isConnect = response.statusCode == 200;
    } catch (e) {
      isConnect = false;
    }
  }
}

}
