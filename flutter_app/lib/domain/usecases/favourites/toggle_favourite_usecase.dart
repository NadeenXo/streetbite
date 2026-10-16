import '../../entities/meal_entity.dart';
import '../../repositories/favourite_repository.dart';

class ToggleFavouriteUseCase {
  final FavouriteRepository repository;

  ToggleFavouriteUseCase(this.repository);

  Future<void> call({required String userId, required MealEntity meal}) async {
    final exists = await repository.isFavourite(userId, meal.id);

    if (exists) {
      await repository.removeFavourite(userId, meal.id);
    } else {
      await repository.addFavourite(userId, meal);
    }
  }
}
