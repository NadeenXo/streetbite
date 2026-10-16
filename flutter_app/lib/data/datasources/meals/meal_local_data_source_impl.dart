import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/meal_model.dart';
import 'meal_local_data_source.dart';

class MealLocalDataSourceImpl implements MealLocalDataSource {
  static const String _cacheKey = 'cached_meals_v1';

  final SharedPreferences preferences;

  MealLocalDataSourceImpl({required this.preferences});

  @override
  Future<void> cacheMeals(List<MealModel> meals) async {
    try {
      final mealsJson = meals.map((meal) => meal.toJson()).toList();

      final encodedMeals = jsonEncode(mealsJson);

      final saved = await preferences.setString(_cacheKey, encodedMeals);

      if (!saved) {
        throw const CacheException();
      }
    } on CacheException {
      rethrow;
    } catch (_) {
      throw const CacheException();
    }
  }

  @override
  Future<List<MealModel>> getCachedMeals() async {
    try {
      final cachedData = preferences.getString(_cacheKey);

      if (cachedData == null) {
        throw const CacheException();
      }

      final decodedData = jsonDecode(cachedData);

      if (decodedData is! List) {
        throw const CacheException();
      }

      return decodedData.map((item) {
        if (item is! Map) {
          throw const CacheException();
        }

        return MealModel.fromJson(Map<String, dynamic>.from(item));
      }).toList();
    } on CacheException {
      rethrow;
    } catch (_) {
      throw const CacheException();
    }
  }
}
