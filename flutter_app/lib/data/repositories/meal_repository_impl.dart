import '../../core/errors/error_handler.dart';
import '../../core/errors/result.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/meals/meal_local_data_source.dart';
import '../datasources/meals/meal_remote_data_source.dart';
import 'meal_data_source_factory.dart';

class MealRepositoryImpl implements MealRepository {
  final MealDataSourceFactory factory;

  const MealRepositoryImpl({required this.factory});

  @override
  Future<Result<List<MealEntity>>> getMeals() async {
    final remote =
        factory.create(MealDataSourceType.remote) as MealRemoteDataSource;

    final local =
        factory.create(MealDataSourceType.local) as MealLocalDataSource;

    try {
      final meals = await remote.getMeals();

      // Save successful API results for offline usage.
      try {
        await local.cacheMeals(meals);
      } catch (_) {
        // A failed cache write should not discard successfully downloaded meals.
      }

      return Success<List<MealEntity>>(meals);
    } catch (error) {
      try {
        final cachedMeals = await local.getCachedMeals();

        return Success<List<MealEntity>>(cachedMeals);
      } catch (_) {
        return ErrorResult<List<MealEntity>>(ErrorHandler.fromException(error));
      }
    }
  }
}
