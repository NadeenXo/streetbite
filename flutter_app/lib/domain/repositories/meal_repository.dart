import '../../core/errors/result.dart';
import '../entities/meal_entity.dart';

abstract class MealRepository {
  Future<Result<List<MealEntity>>> getMeals();
}
