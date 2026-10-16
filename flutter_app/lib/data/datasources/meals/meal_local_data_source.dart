import '../../models/meal_model.dart';

abstract class MealLocalDataSource {
  Future<void> cacheMeals(List<MealModel> meals);

  Future<List<MealModel>> getCachedMeals();
}
