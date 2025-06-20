import 'package:dio/dio.dart';
import 'package:numbersapp/models/models.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://numbersapi.com'));

  Future<NumberFactModel> fetchNumberFact({
    required String number,
    required String category,
  }) async {
    final response = await _dio.get('/$number/$category');
    return NumberFactModel.fromApi(number, category, response.data.toString());
  }
}
