import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/meal_model.dart';
import 'meal_remote_data_source.dart';

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final Dio dio;

  MealRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MealModel>> getMeals() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiConstants.searchMeals,
        queryParameters: {'f': 'a'},
      );

      if (response.statusCode != 200) {
        throw const ServerException();
      }

      final data = response.data;

      if (data == null) {
        throw const ServerException();
      }

      final mealsJson = data['meals'];

      if (mealsJson == null) {
        return [];
      }

      if (mealsJson is! List) {
        throw const ServerException();
      }

      return mealsJson.map((item) {
        if (item is! Map) {
          throw const ServerException();
        }

        return MealModel.fromJson(Map<String, dynamic>.from(item));
      }).toList();
    } on DioException {
      rethrow;
    } on ServerException {
      rethrow;
    } on FormatException {
      throw const ServerException();
    } on TypeError {
      throw const ServerException();
    }
  }
}
