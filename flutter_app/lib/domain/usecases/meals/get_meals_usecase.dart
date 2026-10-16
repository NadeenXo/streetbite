import '../../../core/errors/result.dart';
import '../../entities/meal_entity.dart';
import '../../repositories/meal_repository.dart';

class GetMealsUseCase {
  final MealRepository repository;

  const GetMealsUseCase(this.repository);

  Future<Result<List<MealEntity>>> call() {
    return repository.getMeals();
  }
}
