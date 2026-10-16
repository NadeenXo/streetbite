import '../entities/meal_entity.dart';

abstract class FavouriteRepository {
  Stream<List<MealEntity>> watchFavourites(String userId);

  Future<bool> isFavourite(String userId, String mealId);

  Future<void> addFavourite(String userId, MealEntity meal);

  Future<void> removeFavourite(String userId, String mealId);
}
