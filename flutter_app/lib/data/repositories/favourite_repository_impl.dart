import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/favourite_repository.dart';
import '../datasources/favourites/favourite_remote_data_source.dart';
import '../models/meal_model.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteRemoteDataSource remote;

  FavouriteRepositoryImpl(this.remote);

  @override
  Stream<List<MealEntity>> watchFavourites(String userId) {
    return remote
        .watchFavourites(userId)
        .map((meals) => List<MealEntity>.from(meals));
  }

  @override
  Future<bool> isFavourite(String userId, String mealId) {
    return remote.isFavourite(userId, mealId);
  }

  @override
  Future<void> addFavourite(String userId, MealEntity meal) {
    final model = MealModel(
      id: meal.id,
      name: meal.name,
      category: meal.category,
      area: meal.area,
      imageUrl: meal.imageUrl,
      instructions: meal.instructions,
    );

    return remote.addFavourite(userId, model);
  }

  @override
  Future<void> removeFavourite(String userId, String mealId) {
    return remote.removeFavourite(userId, mealId);
  }
}
