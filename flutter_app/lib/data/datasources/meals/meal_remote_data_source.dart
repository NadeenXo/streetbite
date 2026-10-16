import '../../models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<MealModel>> getMeals();
}
