import 'package:counter_task/Core/Constants/Api_Constants.dart';
import 'package:counter_task/Data/Model/list_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final baseUrl = ApiConstants.baseUrl;

  Future<List<ListModel>> fetchData(int page, {int limit = 10}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts",
        queryParameters: {
          "_start": (page - 1) * limit,
          "_limit": limit,
        },
        options: Options(
          headers: {
            "User-Agent": "Mozilla/5.0",
            "Accept": "application/json",
          },
        ),
      );
      print("@@@@@@@@ Status: ${response.statusCode}");
      print("@@@@@@@@ Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        List data = response.data;
        return data.map((e) => ListModel.fromJson(e)).toList();
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("❌ Status code: ${e.response?.statusCode}");
      print("❌ Data: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("❌ Unexpected error: $e");
      rethrow;
    }

  }
}