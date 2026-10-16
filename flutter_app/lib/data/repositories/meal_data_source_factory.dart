import '../datasources/meals/meal_local_data_source.dart';
import '../datasources/meals/meal_remote_data_source.dart';

enum MealDataSourceType { remote, local }

// Factory Pattern:
// Centralizes selection of the data source according
// to the repository's data retrieval strategy.
class MealDataSourceFactory {
  final MealRemoteDataSource remote;
  final MealLocalDataSource local;

  const MealDataSourceFactory({required this.remote, required this.local});

  Object create(MealDataSourceType type) {
    switch (type) {
      case MealDataSourceType.remote:
        return remote;
      case MealDataSourceType.local:
        return local;
    }
  }
}
